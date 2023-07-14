defmodule ExampleEcto.Repo.Migrations.ChangeUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      modify :age, :string
    end
  end
end
