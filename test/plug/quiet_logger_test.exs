defmodule Plug.QuietLoggerTest do
  use ExUnit.Case
  use Plug.Test

  import ExUnit.CaptureLog

  require Logger

  defmodule MyPlug do
    use Plug.Builder

    plug(Plug.QuietLogger)
    plug(:passthrough)

    defp passthrough(conn, _) do
      Plug.Conn.send_resp(conn, 200, "Passthrough")
    end
  end

  defmodule MyDebugPlug do
    use Plug.Builder

    plug(Plug.QuietLogger, log: :debug)
    plug(:passthrough)

    defp passthrough(conn, _) do
      Plug.Conn.send_resp(conn, 200, "Passthrough")
    end
  end

  defmodule MyCustomPathPlug do
    use Plug.Builder

    plug(Plug.QuietLogger, path: "/api/status")
    plug(:passthrough)

    defp passthrough(conn, _) do
      Plug.Conn.send_resp(conn, 200, "Passthrough")
    end
  end

  defmodule MyMultiPathPlug do
    use Plug.Builder

    plug(Plug.QuietLogger, path: ["/api/status", "/api/health"])
    plug(:passthrough)

    defp passthrough(conn, _) do
      Plug.Conn.send_resp(conn, 200, "Passthrough")
    end
  end

  defp call(conn) do
    MyPlug.call(conn, [])
  end

  defp debug_call(conn) do
    MyDebugPlug.call(conn, [])
  end

  defp custom_path_call(conn) do
    MyCustomPathPlug.call(conn, [])
  end

  defp multi_path_call(conn) do
    MyMultiPathPlug.call(conn, [])
  end

  describe "Plug.QuietLogger.call/2" do
    test "it suppresses logging on the designated health check and log level" do
      log =
        capture_log_lines(fn ->
          call(conn(:get, "/health-check"))
        end)

      assert log == ""
    end

    test "it allows logging on other endpoints" do
      log =
        capture_log_lines(fn ->
          call(conn(:get, "/"))
        end)

      assert Regex.match?(~r/\[info\]  GET \//u, log)
      assert Regex.match?(~r/Sent 200 in [0-9]+[µm]s/u, log)
    end

    test "it allows logging when the level is not the designated one" do
      log =
        capture_log_lines(fn ->
          debug_call(conn(:get, "/health-check"))
        end)

      assert Regex.match?(~r/\[debug\] GET \/health-check/u, log)
      assert Regex.match?(~r/Sent 200 in [0-9]+[µm]s/u, log)
    end

    test "it suppresses logging with a custom request path" do
      log =
        capture_log_lines(fn ->
          custom_path_call(conn(:get, "/api/status"))
        end)

      assert log == ""
    end

    test "it suppresses logging for multiple path" do
      log =
        capture_log_lines(fn ->
          multi_path_call(conn(:get, "/api/status"))
        end)

      assert log == ""

      log =
        capture_log_lines(fn ->
          multi_path_call(conn(:get, "/api/health"))
        end)

      assert log == ""

      log =
        capture_log_lines(fn ->
          multi_path_call(conn(:get, "/api/something"))
        end)

      assert Regex.match?(~r/api\/something/, log)
    end
  end

  defp capture_log_lines(fun) do
    fun
    |> capture_log()
  end
end
