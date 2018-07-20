defmodule ManageTest do
  use ExUnit.Case, async: true

  setup do
    Ecto.Adapters.SQL.Sandbox.checkout(Manage.Repo)
    :ok
  end
end
