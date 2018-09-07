defmodule ExtremeSystem.Example.Api.Helpers.ProxyHelper do
  require Logger

  def users_facade, do: _get_facade(Example.UsersFacade)

  def call_server(facade, command, opts \\ [])

  def call_server(:undefined, _command, _),
    do: {:error, :facade_unavailable}

  def call_server(facade, command, opts),
    do: _call_server(facade, command, merge_with_defaults(opts))

  defp _call_server(facade, command, %{timeout: timeout}),
    do: _proxy(facade, command, timeout)

  defp _proxy(facade, command, timeout, attempt \\ 1) do
    try do
      Logger.debug("Calling #{inspect(facade)} with #{inspect(command)}")
      GenServer.call(facade, command, timeout)
    catch
      :exit, reason ->
        Logger.warn("Calling server #{inspect(facade)} failed with: #{inspect(reason)}.")

        if attempt < 2 do
          Logger.warn("Retrying...")
          _proxy(facade, command, timeout, attempt + 1)
        else
          Logger.error(
            "No more retries after #{inspect(attempt)} attempts. Returning that facade is unavailable!"
          )

          {:error, :facade_unavailable}
        end
    end
  end

  defp merge_with_defaults(opts) do
    [timeout: 2_000]
    |> Keyword.merge(opts)
    |> Enum.into(%{})
  end

  defp _get_facade(facade) do
    case :global.whereis_name(facade) do
      :undefined ->
        # try one more time
        :timer.sleep(100)
        :global.whereis_name(facade)

      res ->
        res
    end
  end
end
