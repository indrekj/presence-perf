# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :presence_perf,
  ecto_repos: [PresencePerf.Repo]

# Configures the endpoint
config :presence_perf, PresencePerfWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DeBSokiNALDcSS4W1o+y2qjFArD+MajY6mQZEMthHriyJ5i70x1h15ABuif7GMhI",
  render_errors: [view: PresencePerfWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PresencePerf.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
