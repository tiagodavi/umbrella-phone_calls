defmodule ApiWeb.Api.V1.TelephoneSystemController do
  use ApiWeb, :controller

  def index(conn, params) do
    case Manage.show_telephone_bill(params) do
      {:ok, data} -> render(conn, "telephone_bill.json", data: data)
      {:error, code, data} -> send_error(conn, code, data)
    end
  end

  def create(conn, params) do
    case Manage.create_telephone_call(params) do
      {:ok, data} ->
        render(conn, "telephone_call.json", data: data)

      {:error, code, data} ->
        send_error(conn, code, data)
    end
  end
end
