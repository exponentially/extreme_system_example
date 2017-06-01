defmodule ExtremeSystem.Example.MessageHandlers.Users do
  alias   ExtremeSystem.Example.Users,   as: App
  use     Extreme.System.MessageHandler, prefix:        App,
                                         aggregate_mod: App.Aggregates.User
  require Logger
  
  def new(cmd) do
    with_new_aggregate("Registering new user", cmd, fn {:ok, pid, id} -> 
      pid |> aggregate_mod().new(id, cmd, Logger.metadata)
    end)
  end
end
