defmodule ApiToEcto.Repo.Migrations.CreatePlace do
  use Ecto.Migration

  def change do
    create table(:places) do
      add :name, :string, null: false
      add :address, :string
      add :lat, :float, null: false
      add :lon, :float, null: false

      timestamps()
    end

    # 自力では複合キーの設定ができなかった
    create unique_index(:places, [:name, :address], name: :places_name_address_index)
  end
end
