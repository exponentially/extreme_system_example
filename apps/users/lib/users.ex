defmodule ExtremeSystem.Example.Users do
  alias   ExtremeSystem.Example, as: Ex
  alias   Extreme.System,        as: ExSys
  use     ExSys.Application

  def _start do
    import Supervisor.Spec, warn: false

    #extreme_settings = Application.get_env :users, :extreme

    children = [
      supervisor( ExSys.FacadeSup, [Ex.Facade, {:global, Example.UsersFacade}]),
    ]

    {:ok, children: children, name: __MODULE__}
  end
end
