defmodule ApiToEcto.Place do
  use Ecto.Schema
  import Ecto.Changeset

  schema "places" do
    field :name, :string
    field :address, :string
    field :lat, :float
    field :lon, :float

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:name, :address, :lat, :lon])
    |> validate_required([:lat, :lon])
    # 動画では name のバリデーションを一つの関数にしていた
    |> validate_required(:name, message: "You need to enter name.")
    |> unique_constraint(:name, name: :places_name_address_index)
    |> unsafe_validate_unique(:name, ApiToEcto.Repo, message: "Name has already been in database.")
  end
end
