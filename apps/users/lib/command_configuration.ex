defmodule ExtremeSystem.Example.Users.CommandConfiguration do
  @moduledoc """
  In this module register your aggregate modules with their stream prefix.

  In this case we are registering User aggregate implemented in
  `ExtremeSystem.Example.Users.Aggregates.User` module. We also specify here prefix
  `ex_users` for this aggregate.

  That means that when you register new user that gets id: 05c03d0c-b29a-11e8-aff9-acbc32d4fe0b,
  it's events will be stored in `ex_users-05c03d0c-b29a-11e8-aff9-acbc32d4fe0b` stream of EventStore.

  Because of the stream naming, if projection `by_category` is started in EventStore, there will be
  indexed stream for all users: `$ce-ex_users`. You can check that one @
  http://localhost:2113/web/index.html#/streams/$ce-ex_users
  """
  alias ExtremeSystem.Example.Users.Aggregates

  use Extreme.System.CommandConfiguration,
    aggregates: [{Aggregates.User, "ex_users"}]
end
