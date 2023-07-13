defmodule ExampleEcto.User do
  use Ecto.Schema

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :age, :integer

    timestamps()
  end
end
