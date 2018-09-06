defmodule ExtremeSystem.Example.Users.Aggregates.UserImpl do
  alias   ExtremeSystem.Example.Events, as: Event
  import  Ecto.Changeset

  def exec(:new, {id, params}, state) do
    [
      %Event.User.Created{id: id, email: params["email"]},
      %Event.User.ProfileSet{id: id, name: params["name"]}
    ]
    |> _events(state)
  end

  def exec(:update_profile, params, state) do
    case _validate_profile_update(params) do
      %{valid?: false}=changeset ->
        {:noblock, {:error, changeset}, state}
      %{changes: data} ->
        [ %Event.User.ProfileSet{id: state.id, name: data.name} ]
        |> _events(state)
    end
  end

  defp _validate_profile_update(params) do
    blank = %{}
    types = %{name: :string}
    {blank, types}
      |> cast(params, Map.keys(types))
      |> validate_required([:name])
      |> validate_length(:name, min: 6)
  end

  defp _events(events, state),
    do: {:block, {:events, events}, state}
end
