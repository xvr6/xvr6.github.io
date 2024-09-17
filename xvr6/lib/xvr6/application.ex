defmodule Xvr6.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Xvr6Web.Telemetry,
      {DNSCluster, query: Application.get_env(:xvr6, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Xvr6.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Xvr6.Finch},
      # Start a worker by calling: Xvr6.Worker.start_link(arg)
      # {Xvr6.Worker, arg},
      # Start to serve requests, typically the last entry
      Xvr6Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Xvr6.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Xvr6Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
