defmodule ExtremeSystem.Example.Api.MetadataPlug do
  import Plug.Conn
  require Logger

  def init(options), do: options

  def call(conn, _options) do
    [req_id] = get_resp_header(conn, "x-request-id")
    metadata = [req_id: req_id]
    Logger.metadata(metadata)
    assign(conn, :metadata, metadata)
  end
end
