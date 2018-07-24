defmodule QuietLogger.Mixfile do
  use Mix.Project

  def project do
    [
      app: :quiet_logger,
      version: "0.2.0",
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/Driftrock/quiet_logger"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.0"},
      {:ex_doc, "~> 0.18", only: :dev, runtime: false},
      {:inch_ex, ">= 0.0.0", only: :docs}
    ]
  end

  defp description do
    "A simple plug to suppress health check logging."
  end

  defp package do
    [
      name: "quiet_logger",
      # These are the default files included in the package
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Alessandro Mencarini"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/Driftrock/quiet_logger"}
    ]
  end
end
