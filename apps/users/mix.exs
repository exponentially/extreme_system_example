defmodule ExtremeSystem.Example.Users.Mixfile do
  use Mix.Project

  def project do
    [app: :users,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [
      mod:                {ExtremeSystem.Example.Users, []},
      applications:       [:extreme_system, :ecto, :gettext],
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      #{:extreme_system, "~> 0.0.4"},
      {:extreme_system, path: "~/elixir/extreme_system"},
      {:ecto, "~> 2.1.4"},
      {:gettext, "~> 0.13"},
    ]
  end
end
