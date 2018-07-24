defmodule Manage.Repo.Migrations.AddRuleIdToTelephoneCalls do
  use Ecto.Migration

  def change do
    alter table("telephone_calls") do
      add :rule_id, :integer, default: 1
    end
  end
end
