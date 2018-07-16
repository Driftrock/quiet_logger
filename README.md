# QuietLogger

[![Build Status](https://travis-ci.org/Driftrock/quiet_logger.svg?branch=master)](https://travis-ci.org/Driftrock/quiet_logger)

A simple plug to suppress health check logging. Useful when running apps in
Kubernetes.

## Installation

The package can be installed by adding `quiet_logger` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:quiet_logger, "~> 0.1.0"}
  ]
end
```

Once that's done you can replace `Plug.Logger` with `Plug.QuietLogger` in your
`endpoint.ex` file and you're ready to go.

If you need to customize the request path you want to suppress logging for, you
can pass it with the `plug` call:

```elixir
plug Plug.QuietLogger, path: "/api/status"
```

If you want to change your logging level you can also set it the same way you
would with `Plug.Logger`:

```elixir
plug Plug.QuietLogger, log: :debug
```
