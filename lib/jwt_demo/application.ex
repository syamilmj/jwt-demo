defmodule JwtDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: JwtDemo.Router, options: [port: 8080]},
      {JwtDemo.Users, []}
    ]

    opts = [strategy: :one_for_one, name: JwtDemo.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
