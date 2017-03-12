defmodule GhAuhenticate.Mixfile do
  use Mix.Project

  def project do
    [app: :gh_auhenticate,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [
      :logger,
      :cowboy,
      :plug,
      :httpoison,
      :uuid,
      :httpoison,
      :poison,
    ],
    mod: {GhAuhenticate, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.0"},
      {:httpoison, "~> 0.10.0"},
      {:uuid, "~> 1.1"},
      {:httpoison, "~> 0.10.0"},
      {:poison, "~> 2.0"},
    ]

  end
end
