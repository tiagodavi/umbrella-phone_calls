defmodule ManageTest do
  use ExUnit.Case
  doctest Manage

  test "greets the world" do
    assert Manage.hello() == :world
  end
end
