defmodule GhAuhenticate do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, GhAuthenticate.Router, [], [port: port])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GhAuhenticate.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def port do
    (System.get_env("PORT") || "4000") |> String.to_integer
  end
end
