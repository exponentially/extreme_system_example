defmodule ExtremeSystem.Example.Api.UsersController do
  use     ExtremeSystem.Example.Api.Web, :controller
  require Logger
  import  ExtremeSystem.Example.Api.Helpers.ResponseHelper, only: [respond_on: 2]
  
  def create(conn, %{}=params) do
    call_server(users_facade(), {:new, params, conn.assigns[:metadata]})
    |> respond_on(conn)
  end
  
  def update_profile(conn, %{}=params) do
    call_server(users_facade(), {:update_profile, params, conn.assigns[:metadata]})
    |> respond_on(conn)
  end
end
