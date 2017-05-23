use Mix.Config

:ok = System.put_env "LIGHTHOUSE", "lighthouse_1@mystique"

config :extreme_system, :nodes, [
    "LIGHTHOUSE"
  ]
