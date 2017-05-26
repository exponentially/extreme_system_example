defmodule ExtremeSystem.Example.Facade do
  use     Extreme.System.Facade, default_cache: 1_000

  alias   ExtremeSystem.Example.MessageHandlers, as: MsgHandler

  route   :new, MsgHandler.Users
end
