# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rest_client,
  ecto_repos: [RestClient.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :rest_client, RestClientWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VbZOkXahRKJQSjMlk1wo9zfHy5fcHjKuh391ocZCzkNBo/FuGcynLsetexMKRfs5",
  render_errors: [view: RestClientWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: RestClient.PubSub,
  live_view: [signing_salt: "Wt3lIC0j"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
