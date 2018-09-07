use Mix.Config

{:ok, hostname} = :inet.gethostname
:ok = System.put_env "ExSysApi", "example_api@#{to_string(hostname)}"
:ok = System.put_env "ExSysUsers", "es_users@#{to_string(hostname)}"

config :extreme_system, :nodes, [
    "ExSysApi", "ExSysUsers"
  ]
