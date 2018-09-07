defmodule ExtremeSystem.Example.Api.Router do
  use ExtremeSystem.Example.Api.Web, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(ExtremeSystem.Example.Api.MetadataPlug)
  end

  scope "/", ExtremeSystem.Example.Api do
    pipe_through(:api)

    post("/users", UsersController, :create)
    put("/users/:id", UsersController, :update_profile)
  end
end
