defmodule ApiToEcto.Places do
  alias ApiToEcto.Repo
  alias ApiToEcto.Place
  import Ecto.Changeset
  import Ecto.Query

  def get_places do
    Repo.all(Place)
  end

  def get_place(id) when is_integer(id) do
    Place
    |> where([p], p.id == ^id)
    |> Repo.one()
    # Repo.get(Place, id) でよい
  end

  def get_place(_id), do: nil

  # def create_place(place) do
  #   place
  #   |> Place.changeset()
  #   |> Repo.insert()
  # end

  def create_place(params) do
    %Place{}
    |> Place.changeset(params)
    |> Repo.insert()
  end

  def update_place(place, changes) do
    place
    |> cast(changes, [:name, :address, :lon, :lat])
    |> Place.changeset()
    |> Repo.update()
    # changeset に cast も含まれるので changeset に params (changes) を渡せばよい
  end

  def delete_place(id) do
    place = get_place(id)

    if is_nil(place) do
      # if の条件式を place の束縛文にすればよい
      nil
    else
      Repo.delete(place)
    end
  end

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
    get_places_to_search_by_address("石神井台")
  end
end
