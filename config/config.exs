# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

defmodule Team8esSecretKey do
  def fetch do
    File.read! System.cwd() <> "/config/team8es_secret"
  end
end

# General application configuration
config :team8es,
  ecto_repos: [Team8es.Repo]

# Configures the endpoint
config :team8es, Team8es.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tRnVKHwJUlwvwFnB+pH17lWuBGlFxNLt4brdYzWINXW4u9wfmZQoynL9m6IBWDNf",
  render_errors: [view: Team8es.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Team8es.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  verify_issuer: true,
  issuer: "Team8es",
  ttl: { 30, :days },
  allowed_drift: 2000,
  secret_key: {Team8esSecretKey, :fetch},
  serializer: Team8es.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
