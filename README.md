# QuietLogger

A simple plug to suppress health check logging. Useful when running apps in
Kubernetes.

## TODO

- [ ] Allow configuration of request path
- [ ] Push to Hex

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `quiet_logger` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:quiet_logger, "~> 0.1.0"}
  ]
end
```

Once that's done you can replace `Plug.Logger` with `Plug.QuietLogger` in your
`endpoint.ex` file and you're ready to go.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/quiet_logger](https://hexdocs.pm/quiet_logger).
