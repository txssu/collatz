defmodule Collatz.MixProject do
  use Mix.Project

  def project do
    [
      app: :collatz,
      version: "1.0.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      escript: [main_module: Collatz.CLI]
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:markex, "~> 1.1"}
    ]
  end
end
