use Mix.Config

config :users, :extreme,
  db_type: :cluster_dns,
  host: "${EVENTSTORE_HOSTNAME}",
  port: 2114,
  gossip_timeout: 1000,
  username: "${EVENTSTORE_UID}",
  password: "${EVENTSTORE_PWD}",
  max_attempts: :infinity,
  mode: :write
