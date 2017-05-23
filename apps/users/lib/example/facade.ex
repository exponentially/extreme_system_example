defmodule ExtremeSystem.Example.Facade do
  use     Extreme.System.Facade

  alias   ExtremeSystem.Example.MessageHandlers, as: MsgHandler

  def on_init, 
    do: Process.register(self(), __MODULE__)

  route :new, MsgHandler.Users
end
