defmodule ExampleEcto.Repo.Migrations.DeleteUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      remove :age
    end
  end
end
