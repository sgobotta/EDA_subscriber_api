defmodule SubscriberApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SubscriberApiWeb.Telemetry,
      SubscriberApi.Repo,
      {DNSCluster, query: Application.get_env(:subscriber_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SubscriberApi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: SubscriberApi.Finch},
      # Start a worker by calling: SubscriberApi.Worker.start_link(arg)
      # {SubscriberApi.Worker, arg},
      # Start to serve requests, typically the last entry
      SubscriberApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SubscriberApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SubscriberApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
