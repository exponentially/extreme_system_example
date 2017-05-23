defmodule ExtremeSystem.Example.Users do
  alias   ExtremeSystem.Example, as: Ex
  alias   Extreme.System,        as: ExSys
  use     ExSys.Application

  @request_sup TempTask

  def _start do
    import Supervisor.Spec, warn: false

    #extreme_settings = Application.get_env :users, :extreme

    children = [
      supervisor( Task.Supervisor,  [[name: @request_sup]]),
      worker(     Ex.Facade,        [@request_sup, [name: {:global, Example.UsersFacade}]]),
    ]

    {:ok, children: children, name: __MODULE__}
  end
end
