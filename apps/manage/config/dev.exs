use Mix.Config

config :manage, Manage.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "ecto://postgres:postgres@localhost/telephone_call_dev"
