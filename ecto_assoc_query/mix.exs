defmodule EctoAssocQuery.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_assoc_query,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {EctoAssocQuery.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.10"},
      {:postgrex, "~> 0.17.2"},
      {:csv, "~> 3.0"}
    ]
  end
end
