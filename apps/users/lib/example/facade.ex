defmodule ExtremeSystem.Example.Facade do
  use     Extreme.System.Facade

  alias   ExtremeSystem.Example.MessageHandlers, as: MsgHandler

  route   :new, MsgHandler.Users
end
