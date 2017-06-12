use Mix.Config

config :api,
  namespace: ExtremeSystem.Example.Api

config :api, ExtremeSystem.Example.Api.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DudwWT2casZn//6HNUPK7grcbR1fd/l7xVxSTbxzFm17FxYhAdTQXC1axwJaFrFT",
  render_errors: [view: ExtremeSystem.Example.Api.ErrorView, accepts: ~w(json)],
  pubsub: [name: ExtremeSystem.Example.Api.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :mix_docker, image: "api"

import_config "#{Mix.env}.exs"
