defmodule ExtremeSystem.Example.MessageHandlers.Users do
  alias   ExtremeSystem.Example.Users,   as: App
  use     Extreme.System.MessageHandler, prefix:        App,
                                         aggregate_mod: App.Aggregates.User
  import  ExtremeSystem.Example.MessageHandlers.ResponseHelper, only: [respond_on: 1]

  def new(cmd) do
    with_new_aggregate("Registering new user", cmd, fn {:ok, pid, id} -> 
      aggregate_mod().new(pid, id, cmd)
    end) |> respond_on
  end

  def update_profile(%{"id" => id}=cmd) do
    with_aggregate("Updating profile for user #{inspect id}", id, fn {:ok, pid} ->
      aggregate_mod().update_profile(pid, cmd)
    end) |> respond_on
  end
end
