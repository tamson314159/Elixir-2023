import Config

config :example_ecto, ExampleEcto.Repo,
  database: "example_ecto_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :example_ecto,
  ecto_repos: [ExampleEcto.Repo]
