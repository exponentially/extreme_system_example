defmodule ExtremeSystem.Example.Users.MessageHandlers.ResponseHelper do
  require Logger

  @gettext_backend ExtremeSystem.Example.Users.Gettext

  def respond_on({:error, %Ecto.Changeset{} = changeset}) do
    response = changeset |> translate_errors
    Logger.warn("Command failed #{inspect(response)}")
    {:error, :validation, response}
  end

  def respond_on(other), do: other

  defp translate_errors(changeset),
    do: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)

  defp translate_error({msg, opts}) do
    if count = opts[:count],
      do: Gettext.dngettext(@gettext_backend, "errors", msg, msg, count, opts),
      else: Gettext.dgettext(@gettext_backend, "errors", msg, opts)
  end

  defp translate_error(msg),
    do: Gettext.dgettext(@gettext_backend, "errors", msg)
end
