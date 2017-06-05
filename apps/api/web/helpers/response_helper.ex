defmodule ExtremeSystem.Example.Api.Helpers.ResponseHelper do
  use     ExtremeSystem.Example.Api.Web, :controller
  require Logger

  @aggregate_ver_header "x-aggregate-version"

  def respond_on({:error, :facade_unavailable}, conn), do: send_resp(conn, 503, "")
  def respond_on(:ok, conn), do: send_resp(conn, 204, "")
  def respond_on({:ok, %{}=response}, conn) do
    conn
    |> put_status(200)
    |> json(response)
  end
  def respond_on({:ok, list}, conn) when is_list(list) do
    conn
    |> put_status(200)
    |> json(list)
  end
  def respond_on({:ok, :json, json}, conn) do
    conn
    |> put_status(200)
    |> put_resp_content_type("application/json")
    |> text(json)
  end
  def respond_on({:ok, ver}, conn) do
    conn
    |> put_resp_header(@aggregate_ver_header, ver |> to_string)
    |> put_status(204)
    |> json("")
  end
  def respond_on({:created, payload, ver}, conn) when is_map(payload) do
    conn
    |> put_resp_header(@aggregate_ver_header, ver |> to_string)
    |> put_status(201)
    |> json(payload)
  end
  def respond_on({:created, id, ver}, conn) do
    conn
    |> put_resp_header(@aggregate_ver_header, ver |> to_string)
    |> put_status(201)
    |> json(%{id: id})
  end
  def respond_on({:error, :bad_request, reason}, conn) do
    conn
    |> put_status(400)
    |> json(%{error: "Bad request", errors: reason})
  end
  def respond_on({:error, :bad_credentials}, conn) do
    conn
    |> put_status(401)
    |> json(%{error: "Bad credentials"})
  end
  def respond_on({:error, :not_authorized}, conn) do
    conn
    |> put_status(403)
    |> json(%{error: "You are not authorized for requested action"})
  end
  def respond_on({:error, :not_authorized, reason}, conn) do
    conn
    |> put_status(403)
    |> json(%{error: "You are not authorized for requested action", reason: reason})
  end
  def respond_on({:error, :not_found}, conn) do
    conn
    |> put_status(404)
    |> json(%{})
  end
  def respond_on({:error, :conflict, reason}, conn) do
    conn
    |> put_status(409)
    |> json(%{error: "conflict situation", reason: reason})
  end
  def respond_on({:error, :wrong_expected_version, -1}, conn) do
    conn
    |> put_status(412)
    |> json(%{error: "duplicate key", reason: "Attempt to register new aggregate with existing key"})
  end
  def respond_on({:error, :wrong_expected_version, sent_version}, conn) do
    conn
    |> put_status(412)
    |> json(%{error: "concurrency error", expected_version: sent_version})
  end
  def respond_on({:error, :wrong_expected_version, aggregate_version, sent_version}, conn) do
    conn
    |> put_resp_header(@aggregate_ver_header, aggregate_version |> to_string)
    |> put_status(412)
    |> json(%{error: "concurrency error", aggregate_version: aggregate_version, expected_version: sent_version})
  end
  def respond_on({:error, :validation, errors}, conn) do
    conn
    |> put_status(422)
    |> json(%{error: "validation error", errors: errors})
  end
end
