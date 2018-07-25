defmodule ManageTest do
  use ExUnit.Case, async: true

  setup do
    Ecto.Adapters.SQL.Sandbox.checkout(Manage.Repo)
    :ok
  end

  test "type can't be invalid" do
    data = %{
      "type" => "unknown",
      "timestamp" => "2016-02-29T12:00:00Z",
      "call_id" => "1",
      "source" => "99988526423",
      "destination" => "99988526423"
    }

    assert Manage.create_telephone_call(data) == {:error, "Invalid Type"}
  end

  test "source and destination can't be equal" do
    data = %{
      "type" => "start",
      "timestamp" => "2016-02-29T12:00:00Z",
      "call_id" => "1",
      "source" => "99988526423",
      "destination" => "99988526423"
    }

    assert {:error, changeset} = Manage.create_telephone_call(data)
    assert changeset.errors == [numbers: {"phone numbers are the same", []}]
  end

  test "source or destination can't be less than 10 or 11 digits" do
    data = %{
      "type" => "start",
      "timestamp" => "2016-02-29T12:00:00Z",
      "call_id" => "1",
      "source" => "99988526423",
      "destination" => "999885264"
    }

    assert {:error, changeset} = Manage.create_telephone_call(data)
    assert changeset.errors == [destination: {"has invalid format", [validation: :format]}]
  end

  test "can't create duplicate call start" do
    call_start = %{
      "type" => "start",
      "timestamp" => "2017-12-12T14:00:03Z",
      "call_id" => 1,
      "source" => "99988526423",
      "destination" => "99988526427"
    }

    assert {:ok, _} = Manage.create_telephone_call(call_start)
    assert {:error, message} = Manage.create_telephone_call(call_start)

    assert message == "Call Start already created for this call_id"
  end

  test "can't create duplicate call end" do
    call_end = %{
      "type" => "end",
      "timestamp" => "2017-12-12T14:00:03Z",
      "call_id" => 1
    }

    assert {:ok, _} = Manage.create_telephone_call(call_end)
    assert {:error, message} = Manage.create_telephone_call(call_end)

    assert message == "Call End already created for this call_id"
  end

  test "creates call start record" do
    call_start = %{
      "type" => "start",
      "timestamp" => "2016-02-29T12:00:00",
      "call_id" => 1,
      "source" => "99988526423",
      "destination" => "99988526427"
    }

    assert {:ok, data} = Manage.create_telephone_call(call_start)
    assert data.call_id == call_start["call_id"]
    assert data.type == call_start["type"]
  end

  test "creates call end record" do
    call_end = %{
      "type" => "end",
      "timestamp" => "2016-02-29T12:00:00",
      "call_id" => 1
    }

    assert {:ok, data} = Manage.create_telephone_call(call_end)
    assert data.call_id == call_end["call_id"]
    assert data.type == call_end["type"]
  end

  test "returns telephone bill" do
    previous =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.add(-2_592_000)

    {:ok, previous_a} = NaiveDateTime.new(NaiveDateTime.to_date(previous), ~T[21:10:00.000])

    previous_b =
      previous_a
      |> NaiveDateTime.add(120)

    call_start = %{
      "type" => "start",
      "timestamp" => NaiveDateTime.to_string(previous_a),
      "call_id" => 1,
      "source" => "99988526423",
      "destination" => "99988526427"
    }

    call_end = %{
      "type" => "end",
      "timestamp" => NaiveDateTime.to_string(previous_b),
      "call_id" => 1
    }

    assert {:ok, _} = Manage.create_telephone_call(call_start)
    assert {:ok, _} = Manage.create_telephone_call(call_end)

    assert {:ok, [report | _]} =
             Manage.show_telephone_bill(%{
               "phone_number" => "99988526423"
             })

    assert report.call_duration == "0h2m0s"
    assert report.call_price == 0.54
  end
end
