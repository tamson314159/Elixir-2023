defmodule ApiToEcto.Repo.Migrations.CreateAccessPoint do
  use Ecto.Migration

  def change do
    create table(:access_points) do
      add :name, :string
      add :address, :string
      add :lat, :float, null: false
      add :lon, :float, null: false

      timestamps()
    end
  end
end
