defmodule ExtremeSystem.Example.Api.Router do
  use     ExtremeSystem.Example.Api.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExtremeSystem.Example.Api do
    pipe_through :api
  end
end
