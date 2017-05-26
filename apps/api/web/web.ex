defmodule ExtremeSystem.Example.Api.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use ExtremeSystem.Example.Api.Web, :controller
      use ExtremeSystem.Example.Api.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      # Define common model functionality
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, namespace: ExtremeSystem.Example.Api

      import ExtremeSystem.Example.Api.Router.Helpers
      import ExtremeSystem.Example.Api.Gettext
      import ExtremeSystem.Example.Api.Helpers.ProxyHelper
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates", namespace: ExtremeSystem.Example.Api

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      import ExtremeSystem.Example.Api.Router.Helpers
      import ExtremeSystem.Example.Api.ErrorHelpers
      import ExtremeSystem.Example.Api.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import ExtremeSystem.Example.Api.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
