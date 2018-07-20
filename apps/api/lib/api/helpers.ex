defmodule Api.Helpers do
  @moduledoc false

  import Plug.Conn, only: [put_status: 2]
  import Phoenix.Controller, only: [render: 3, put_view: 2]

  def send_error(conn, code, message) when is_binary(message) do
    conn |> prepare_send_error(code) |> render("#{code}.json", %{errors: message})
  end

  def send_error(conn, code, changeset) do
    conn |> prepare_send_error(code) |> render("#{code}.json", %{errors: changeset})
  end

  defp prepare_send_error(conn, code) do
    conn
    |> put_status(code)
    |> put_view(ApiWeb.ErrorView)
  end
end
