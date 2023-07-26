defmodule HouseholdAccountBookApp.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :category_name, :string
      add :color_code, :string, default: "#f0e68c"

      timestamps()
    end
  end
end
