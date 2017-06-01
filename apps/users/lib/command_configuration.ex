defmodule ExtremeSystem.Example.Users.CommandConfiguration do
  alias   ExtremeSystem.Example.Users.Aggregates
  use     Extreme.System.CommandConfiguration, aggregates: [{Aggregates.User, "ex_users"}]
end
