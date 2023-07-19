defmodule EctoTransaction.Core do
  alias EctoTransaction.{Repo, User, Point, PointLog, Item, GetItem}
  alias Ecto.Multi
  import Ecto.Query

  def create_user(params) do
    Multi.new()
    |> Multi.insert(:user, User.changeset(%User{}, params))
    |> Multi.insert(:point, fn %{user: user} ->
      Point.changeset(%Point{user: user}, %{point_balance: 1000})
    end)
    |> Multi.insert(:point_log, fn %{user: user} ->
      PointLog.changeset(%PointLog{user: user}, %{category: "give", amount: 1000, point_balance: 1000})
    end)
    |> Repo.transaction()
  end

  def buy_item(user_id, item_id) do
    user = Repo.get(User, user_id) |> Repo.preload(:point)
    item = Repo.get(Item, item_id)

    if user && item do
      Multi.new()
      |> Multi.insert(:get_item, %GetItem{user: user, item: item})
      |> Multi.update(:point, fn _ ->
        point_balance = user.point.point_balance - item.price
        Point.changeset(user.point, %{point_balance: point_balance})
      end)
      |> Multi.insert(:point_log, fn %{point: point} ->
        PointLog.changeset(%PointLog{user: user}, %{category: "use", amount: item.price, point_balance: point.point_balance})
      end)
      |> Repo.transaction()
    else
      nil
    end
  end

  def delete_user(user_id) do
    Multi.new()
    |> Multi.run(:user, fn repo, _changes ->
      case repo.get(User, user_id) do
        nil -> {:error, :not_found}
        user -> {:ok, user}
      end
    end)
    # :point, :point_logs, :get_item は user_id を直接使えばよくない？
    |> Multi.delete(:point, fn %{user: _user} ->
      # query = from(p in Point, where: p.user_id == ^user.id)
      query = from(p in Point, where: p.user_id == ^user_id)
      Repo.one(query)
    end)
    |> Multi.delete_all(:point_logs, fn %{user: user} ->
      from(pl in PointLog, where: pl.user_id == ^user.id)
    end)
    |> Multi.delete_all(:get_item, fn %{user: user} ->
      from(gi in GetItem, where: gi.user_id == ^user.id)
    end)
    |> Multi.delete(:delete_user, fn %{user: user} -> user end)
    |> Repo.transaction()
  end
end
