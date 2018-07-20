defmodule Manage.Repo.Migrations.AddTelephoneCallsTable do
  use Ecto.Migration

  def change do
    create table("telephone_calls") do
      add :type, :string, null: false
      add :timestamp, :naive_datetime, null: false
      add :call_id, :integer, null: false
      add :source, :string, null: true
      add :destination, :string, null: true
      timestamps()
    end
  end
end
