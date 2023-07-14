defmodule ExampleEcto.Repo do
  use Ecto.Repo,
    otp_app: :example_ecto,
    adapter: Ecto.Adapters.Postgres
end
