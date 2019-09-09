defmodule PresencePerf.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # PresencePerf.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PresencePerf.PubSub},
      # Presence
      PresencePerf.Presence,
      # Start the Endpoint (http/https)
      PresencePerfWeb.Endpoint
      # Start a worker by calling: PresencePerf.Worker.start_link(arg)
      # {PresencePerf.Worker, arg}
    ] ++ cluster_specs()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PresencePerf.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PresencePerfWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def cluster_specs do
    case Confex.fetch_env(:presence_perf, :libcluster) do
      {:ok, conf} ->
        topologies = Keyword.fetch!(conf, :topologies)
        [{Cluster.Supervisor, [topologies, [name: Transporter.ClusterSupervisor]]}]

      _other ->
        []
    end
  end
end
