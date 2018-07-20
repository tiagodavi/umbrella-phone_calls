use Mix.Config

config :manage, Manage.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  url: "ecto://postgres:postgres@localhost/telephone_call_test"
