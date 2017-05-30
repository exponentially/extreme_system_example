defmodule ExtremeSystem.Example.MessageHandlers.Users do
  require Logger
  
  def new(payload) do
    Logger.debug "New User is coming: #{inspect payload}"
    {:created, 123}
  end
end
