defmodule ApiWeb.Api.V1.TelephoneSystemControllerTest do
  use ApiWeb.ConnCase, async: true

  setup %{conn: conn} do
    Ecto.Adapters.SQL.Sandbox.checkout(Manage.Repo)
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "api/v1/telephone-calls" do
    setup %{conn: conn} do
      {:ok, conn: conn, path: api_v1_telephone_system_path(conn, :create)}
    end

    test "returns errors when type is invalid", %{conn: conn, path: path} do
      data = %{
        "type" => "unknown",
        "timestamp" => "2016-02-29T12:00:00Z",
        "call_id" => "1",
        "source" => "99988526423",
        "destination" => "99988526423"
      }

      conn = post(conn, path, call: data)
      response = json_response(conn, 403)["errors"]

      assert response == %{"message" => "Invalid Type"}
    end

    test "returns errors when source and destination are the same", %{conn: conn, path: path} do
      data = %{
        "type" => "start",
        "timestamp" => "2016-02-29T12:00:00Z",
        "call_id" => "1",
        "source" => "99988526423",
        "destination" => "99988526423"
      }

      conn = post(conn, path, data)
      response = json_response(conn, 403)["errors"]

      assert response == %{"message" => %{"numbers" => ["phone numbers are the same"]}}
    end

    test "returns errors when source or destination are less than eleven", %{
      conn: conn,
      path: path
    } do
      data = %{
        "type" => "start",
        "timestamp" => "2016-02-29T12:00:00Z",
        "call_id" => "1",
        "source" => "99988526423",
        "destination" => "9998852642"
      }

      conn = post(conn, path, data)
      response = json_response(conn, 403)["errors"]

      assert response == %{"message" => %{"destination" => ["has invalid format"]}}
    end

    test "creates call start record", %{conn: conn, path: path} do
      data = %{
        "type" => "start",
        "timestamp" => "2016-02-29T12:00:00",
        "call_id" => 1,
        "source" => "99988526423",
        "destination" => "99988526427"
      }

      conn = post(conn, path, data)
      response = json_response(conn, 200)["data"]

      assert %{"id" => id} = response

      assert response == %{
               "id" => id,
               "type" => data["type"],
               "call_id" => data["call_id"],
               "timestamp" => data["timestamp"],
               "source" => data["source"],
               "destination" => data["destination"]
             }
    end

    test "creates call end record", %{conn: conn, path: path} do
      data = %{
        "type" => "end",
        "timestamp" => "2016-02-29T12:00:00",
        "call_id" => 1
      }

      conn = post(conn, path, data)
      response = json_response(conn, 200)["data"]

      assert %{"id" => id} = response

      assert response == %{
               "id" => id,
               "type" => data["type"],
               "call_id" => data["call_id"],
               "timestamp" => data["timestamp"],
               "source" => nil,
               "destination" => nil
             }
    end
  end

  describe "api/v1/telephone-bills" do
    setup %{conn: conn} do
      {:ok, conn: conn, path: api_v1_telephone_system_path(conn, :index)}
    end
  end
end
