defmodule Plug.QuietLogger do
  @behaviour Plug

  def init(opts) do
    Plug.Logger.init(opts)
  end

  def call(%{request_path: "/health-check"} = conn, :info), do: conn

  def call(conn, level) do
    Plug.Logger.call(conn, level)
  end
end
