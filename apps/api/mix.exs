defmodule ExtremeSystem.Example.Api.Mixfile do
  use Mix.Project

  def project do
    [
      app: :api,
      version: "0.0.1-build.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      # build_path: "_build",
      # config_path: "config/config.exs",
      # deps_path: "deps",
      # lockfile: "mix.lock",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {ExtremeSystem.Example.Api, []},
      applications: [:phoenix, :phoenix_pubsub, :cowboy, :logger, :gettext, :extreme_system]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_), do: ["lib", "web"]

  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:gettext, "~> 0.13"},
      {:cowboy, "~> 1.1"},
      {:extreme_system, "~> 0.2.14"}
    ]
  end
end
