# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :buDuoTravel,
  ecto_repos: [BuDuoTravel.Repo]

# Configures the endpoint
config :buDuoTravel, BuDuoTravelWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "t4+t1ISRfs5d7IkmYId6ESfj/Pelku+QZCj4HZVT3L/eTifgn/XsH5Nmg4zzNd5K",
  render_errors: [view: BuDuoTravelWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BuDuoTravel.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
