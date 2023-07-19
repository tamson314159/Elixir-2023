defmodule EctoAssocQuery.Core do
  alias EctoAssocQuery.{Repo, User, Artist}
  import Ecto.Query

  def get_active_users() do
    query =
      from(u in User,
        join: au in assoc(u, :active_user)
      )

    Repo.all(query)
  end

  def get_artist_list(user_id) do
    query =
      from(a in Artist,
        join: ml in assoc(a, :music_lists),
        join: m in assoc(ml, :musics),
        join: plm in assoc(m, :play_list_musics),
        join: pl in assoc(plm, :play_list),
        join: u in assoc(pl, :user),
        where: u.id == ^user_id
      )

    query
    |> Repo.all()
    |> Enum.sort()
    |> Enum.uniq()
  end
end
