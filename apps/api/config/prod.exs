use Mix.Config

config :api, ExtremeSystem.Example.Api.Endpoint,
  http: [port: "${PORT}"],
  url: [host: "${HOST}", port: "${PORT}"],
  secret_key_base: "${SECRET_KEY_BASE}",
  server: true
  #we serve API only, so we don't need 2 lines below
  #cache_static_manifest: "priv/static/manifest.json",
  #root: "."

config :logger,
  level: :info,
  format: "$date $time [$level] $metadata$message\n",
  metadata: [:pid, :req_id]

