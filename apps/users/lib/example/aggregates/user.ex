defmodule ExtremeSystem.Example.Users.Aggregates.User do
  use     Extreme.System.GenAggregate
  alias   ExtremeSystem.Example.Events, as: Event

  defmodule State, 
    do: defstruct GenAggregate.state_params ++ 
        [:id, :name]


  ## Client API

  def start_link(ttl \\ 2_000, opts \\ []),
    do: GenAggregate.start_link(__MODULE__, ttl, opts)

  def new(server, id, cmd),
    do: exec(server, {:new, id, cmd})

  def update_profile(server, cmd),
    do: exec(server, {:update_profile, cmd})


  ## Server Callbacks

  def init(ttl),
    do: {:ok, struct(State, initial_state(ttl))}

  ### Command handling

  def handle_exec({:new, id, cmd}, from, state) do
    events = [
      %Event.User.Created{id: id, email: cmd["email"]},
      %Event.User.ProfileSet{id: id, name: cmd["name"]}
    ]
    {:block, from, {:events, events}, state}
  end

  def handle_exec({_cmd, %{"id" => id, "version" => expected_version}}, from, %{id: id, version: current_version}=state) when expected_version != current_version,
    do: {:noblock, from, {:error, :wrong_expected_version, current_version, expected_version}, state}

  def handle_exec({:update_profile, %{"id" => id, "name" => name}}, from, %{id: id}=state) when name == "invalid",
    do: {:noblock, from, {:error, :conflict, "name can't be #{inspect name}"}, state}
  def handle_exec({:update_profile, %{"id" => id, "name" => name}}, from, %{id: id, name: name}=state),
    do: {:noblock, from, {:ok, state.version}, state}
  def handle_exec({:update_profile, %{"id" => id}=cmd}, from, %{id: id}=state) do
    case _update_profile(cmd, state) do
      {:ok, events} -> {:block,   from, {:events, events}, state}
      other         -> {:noblock, from, other,             state}
    end
  end

  def handle_exec({cmd, payload}, from, state),
    do: {:noblock, from, {:error, :conflict, "Can't execute #{inspect cmd} with: #{inspect payload}"}, state}

  defp _update_profile(cmd, state) do
    events = [
      %Event.User.ProfileSet{id: state.id, name: cmd["name"]}
    ]
    {:ok, events}
  end

  ### Apply events

  defp apply_event(%Event.User.Created{}=event, state) do
    %State{state| 
      id: event.id
    }
  end
  defp apply_event(%Event.User.ProfileSet{}=event, state) do
    %State{state| 
      name: event.name
    }
  end
  defp apply_event(_, state), do: state
end
