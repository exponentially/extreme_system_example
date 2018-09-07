defmodule ExtremeSystem.Example.Users.Facade do
  @moduledoc """
  Facade modules are entry point to your application. Like router in Phoenix project.
  In this case we specify that for GenServer call {:new, params, metadata} we will be
  sent to `ExtremeSystem.Example.MessageHandlers.Users.new/2` function.

  Each route call is run in it's own process.

  Here's also specified cache of 1_000ms. Each call is hashed and stored in cache
  together with it's response. That will stay in cache for 1sec. If you don't won't cache,
  you can specify `:no_cache` instead of `1_000`.
  
  Default caching can be overriden for specific route like here for `:new` route.
  """
  use Extreme.System.Facade, default_cache: 1_000, cache_overrides: [new: :no_cache]

  alias ExtremeSystem.Example.MessageHandlers, as: MsgHandler

  route(:new, MsgHandler.Users)
  route(:update_profile, MsgHandler.Users)
end
