defmodule ExtremeSystem.Example.Users.Aggregates.User do
  use Extreme.System.GenAggregate
  alias ExtremeSystem.Example.Events, as: Event
  alias ExtremeSystem.Example.Users.Aggregates.UserImpl, as: Impl

  defmodule(State,
    do: defstruct(GenAggregate.state_params() ++ [:id, :name])
  )

  def start_link(ttl \\ 2_000, opts \\ []),
    do: GenAggregate.start_link(__MODULE__, ttl, opts)

  def init(ttl),
    do: {:ok, struct(State, initial_state(ttl))}

  handle_cmd(:new, {id, params}, metadata, fn
    from, _, state ->
      _exec(:new, {id, params}, from, state)
  end)

  handle_cmd(:update_profile, params, metadata, fn
    # params for anonimous function mean: from, params_from_the_above, current_aggregate_state
    from, %{"name" => name}, %{name: name} = state ->
      # Name is the same as the one we already have. Return ok but don't generate events
      _ok(from, state)

    from, _, state ->
      # Name is changed, proceed with processing...
      _exec(:update_profile, params, from, state)
  end)

  defp _exec(cmd, params, from, state) do
    {label, response, new_state} = Impl.exec(cmd, params, state)
    {label, from, response, new_state}
  end

  ### Apply events

  defp apply_event(%Event.User.Created{} = event, state) do
    %State{state | id: event.id}
  end

  defp apply_event(%Event.User.ProfileSet{} = event, state) do
    %State{state | name: event.name}
  end

  defp apply_event(_, state), do: state
end
