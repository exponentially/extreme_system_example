defmodule ExtremeSystem.Example.Users.Aggregates.User do
  use     Extreme.System.GenAggregate
  alias   ExtremeSystem.Example.Events, as: Event
  require Logger

  defmodule State do
    defstruct GenAggregate.state_params ++ [:id]
  end


  ## Client API

  def start_link(ttl \\ 2_000, opts \\ []),
    do: GenAggregate.start_link(__MODULE__, ttl, opts)

  def new(server, id, cmd, metadata),
    do: exec(server, {:new, id, cmd, metadata})


  ## Server Callbacks

  def init(ttl) do
    Logger.debug "Spawned User aggregate #{inspect self()}"
    {:ok, struct(State, initial_state(ttl))}
  end

  ### Command handling

  def handle_exec({:new, id, cmd, metadata}, from, state) do
    Logger.metadata metadata
    Logger.debug "Registering new user: #{inspect cmd}"
    events = [
      %Event.User.Created{id: id, email: cmd["email"]},
      %Event.User.ProfileSet{id: id, name: cmd["name"]}
    ]
    result = {:block, from, {:events, events}, state}
    Logger.metadata []
    result
  end

  ### Apply events

  defp apply_event(%Event.User.Created{}=event, state) do
    %State{state| 
      id: event.id
    }
  end
  defp apply_event(_, state), do: state
end
