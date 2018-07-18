defmodule ApiWeb.CatchAllController do
  use ApiWeb, :controller

  def index(conn, _params) do
    json conn, %{errors: %{message: "Endpoint not found!"}}
  end
end
