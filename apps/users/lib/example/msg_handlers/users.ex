defmodule ExtremeSystem.Example.MessageHandlers.Users do
  alias   ExtremeSystem.Example.Users,   as: App
  use     Extreme.System.MessageHandler, prefix:        App,
                                         aggregate_mod: App.Aggregates.User,
                                         pipe_response_thru: &App.MessageHandlers.ResponseHelper.respond_on/1

  proxy_to_new_aggregate :new
  proxy_to_aggregate     :update_profile
end
