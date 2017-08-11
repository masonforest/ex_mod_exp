defmodule OpenSSL.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [app: :ex_mod_exp,
     version: @version,
     elixir: ">= 0.14.3 and < 2.0.0",
     compilers: [:elixir, :app],
     deps: deps()]
  end

  def application do
    []
  end

  defp deps do
    []
  end
end
