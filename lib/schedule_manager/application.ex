defmodule ScheduleManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ScheduleManagerWeb.Telemetry,
      ScheduleManager.Repo,
      {DNSCluster, query: Application.get_env(:schedule_manager, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ScheduleManager.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ScheduleManager.Finch},
      # Start a worker by calling: ScheduleManager.Worker.start_link(arg)
      # {ScheduleManager.Worker, arg},
      # Start to serve requests, typically the last entry
      ScheduleManagerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ScheduleManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ScheduleManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
