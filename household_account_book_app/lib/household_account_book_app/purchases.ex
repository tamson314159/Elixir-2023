defmodule HouseholdAccountBookApp.Purchases do
  @moduledoc """
  The Purchases context.
  """

  import Ecto.Query, warn: false
  alias HouseholdAccountBookApp.Repo

  alias HouseholdAccountBookApp.Purchases.Purchase
  alias HouseholdAccountBookApp.Purchases.Category

  def keyword_list_categories() do
    Category
    |> Repo.all()
    |> Enum.reduce([], fn %Category{id: id, category_name: category_name}, list ->
      Keyword.merge(list, "#{category_name}": "#{id}")
    end)
  end

  @doc """
  Returns the list of purchases.

  ## Examples

      iex> list_purchases()
      [%Purchase{}, ...]

  """
  def list_purchases do
    Repo.all(Purchase)
  end

  @doc """
  Gets a single purchase.

  Raises `Ecto.NoResultsError` if the Purchase does not exist.

  ## Examples

      iex> get_purchase!(123)
      %Purchase{}

      iex> get_purchase!(456)
      ** (Ecto.NoResultsError)

  """
  def get_purchase!(id), do: Repo.get!(Purchase, id)

  def get_money_by_categories(date) do
    {start_date, end_date} = format_start_date_and_end_date(date)

    query =
      from(p in Purchase,
        join: c in assoc(p, :category),
        where: p.date >= ^start_date and p.date <= ^end_date,
        group_by: c.category_name,
        select: {c.category_name, sum(p.money)}
      )

    query
    |> Repo.all()
    |> Enum.map(fn {category_name, money} ->
      category = Repo.get_by(Category, category_name: category_name)
      {category.category_name, category.color_code, money}
    end)
  end

  def get_money_by_date(date) do
    {start_date, end_date} = format_start_date_and_end_date(date)

    query =
      from(p in Purchase,
        where: p.date >= ^start_date and p.date <= ^end_date,
        group_by: p.date,
        select: {p.date, sum(p.money)}
      )

    money_by_date =
      query
      |> Repo.all()
      |> Enum.reduce(%{}, fn {date, money}, map ->
        Map.merge(map, %{"#{date.year}-#{date.month}-#{date.day}" => money})
      end)

    for day <- 1..end_date.day do
      create_date = Date.new!(end_date.year, end_date.month, day)
      %Date{year: year, month: month, day: day} = create_date
      key = "#{year}-#{month}-#{day}"
      money = Map.get(money_by_date, key, 0)

      {create_date, money}
    end
  end

  defp format_start_date_and_end_date(%Date{year: year, month: month}) do
    start_date = Date.new!(year, month, 1)
    end_date = Date.end_of_month(start_date)

    {start_date, end_date}
  end

  @doc """
  Creates a purchase.

  ## Examples

      iex> create_purchase(%{field: value})
      {:ok, %Purchase{}}

      iex> create_purchase(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_purchase(attrs \\ %{}) do
    %Purchase{}
    |> Purchase.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a purchase.

  ## Examples

      iex> update_purchase(purchase, %{field: new_value})
      {:ok, %Purchase{}}

      iex> update_purchase(purchase, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_purchase(%Purchase{} = purchase, attrs) do
    purchase
    |> Purchase.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a purchase.

  ## Examples

      iex> delete_purchase(purchase)
      {:ok, %Purchase{}}

      iex> delete_purchase(purchase)
      {:error, %Ecto.Changeset{}}

  """
  def delete_purchase(%Purchase{} = purchase) do
    Repo.delete(purchase)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking purchase changes.

  ## Examples

      iex> change_purchase(purchase)
      %Ecto.Changeset{data: %Purchase{}}

  """
  def change_purchase(%Purchase{} = purchase, attrs \\ %{}) do
    Purchase.changeset(purchase, attrs)
  end
end
