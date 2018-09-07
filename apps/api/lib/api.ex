defmodule ExtremeSystem.Example.Api do
  use Extreme.System.Application
  # use     Application

  #  def start(_, _) do
  #    import Supervisor.Spec
  #
  #    children = [
  #      supervisor(ExtremeSystem.Example.Api.Endpoint, []),
  #    ]
  #
  #    opts     = [strategy: :one_for_one, name: ExtremeSystem.Example.Api.Supervisor]
  #    Supervisor.start_link(children, opts)
  #  end

  def _start do
    import Supervisor.Spec

    children = [
      supervisor(ExtremeSystem.Example.Api.Endpoint, [])
    ]

    {:ok, children: children, name: ExtremeSystem.Example.Api.Supervisor}
  end

  def config_change(changed, _new, removed) do
    ExtremeSystem.Example.Api.Endpoint.config_change(changed, removed)
    :ok
  end
end
