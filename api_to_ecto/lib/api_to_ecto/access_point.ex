defmodule ApiToEcto.AccessPoint do
  use Ecto.Schema

  schema "access_points" do
    field :name, :string
    field :address, :string
    field :lat, :float
    field :lon, :float

    timestamps()
  end
end
