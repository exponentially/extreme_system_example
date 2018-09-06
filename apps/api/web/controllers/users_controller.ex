defmodule ExtremeSystem.Example.Api.UsersController do
  use     ExtremeSystem.Example.Api.Web, :controller
  require Logger
  import  ExtremeSystem.Example.Api.Helpers.ResponseHelper, only: [respond_on: 2]
  
  def create(conn, %{}=params) do
    users_facade()
    |> call_server({:new, params, conn.assigns[:metadata]})
    |> respond_on(conn)
  end
  
  def update_profile(conn, %{}=params) do
    users_facade()
    |> call_server({:update_profile, params, conn.assigns[:metadata]})
    |> respond_on(conn)
  end
end
