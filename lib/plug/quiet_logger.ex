defmodule Plug.QuietLogger do
  @behaviour Plug

  def init(opts) do
    path = Keyword.get(opts, :path, "/health-check")
    log = Keyword.get(opts, :log, :info)

    %{log: log, path: path}
  end

  def call(%{request_path: path} = conn, %{log: :info, path: path}), do: conn

  def call(conn,  %{log: log}) do
    Plug.Logger.call(conn, log)
  end
end
