defmodule ApiToEcto.Places do
  alias ApiToEcto.Repo
  # ApiToEcto.Place もエイリアスいておいた方がいい
  import Ecto.Query

  def get_place_by_name(name) do
    ApiToEcto.Place
    |> where([p], p.name == ^name)
    |> Repo.all()
    # Repo.one() を使う
  end

  def name_search() do
    get_place_by_name("131200006003")
  end

  def select_address do
    ApiToEcto.Place
    |> select([p], p.address)
    |> Repo.all()
  end

  def get_places_to_search_by_address(address) do
    address = "%#{address}%"

    from(p in ApiToEcto.Place, where: like(p.address, ^address))
    |> Repo.all()
  end

  def ad_search() do
    get_places_to_search_by_address("練馬")
  end
end
