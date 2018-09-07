defmodule ExtremeSystem.Example.Users do
  alias ExtremeSystem.Example.Users, as: App
  alias Extreme.System, as: ExSys
  use ExSys.Application

  def _start do
    import Supervisor.Spec, warn: false

    extreme_settings = Application.get_env(:users, :extreme)

    children = [
      supervisor(ExSys.CommandSup, [App.CommandConfiguration, App, extreme_settings]),
      supervisor(ExSys.FacadeSup, [App.Facade, {:global, Example.UsersFacade}])
    ]

    {:ok, children: children, name: __MODULE__}
  end
end
