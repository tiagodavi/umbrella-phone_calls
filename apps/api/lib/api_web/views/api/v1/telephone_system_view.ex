defmodule ApiWeb.Api.V1.TelephoneSystemView do
  use ApiWeb, :view

  def render("telephone_call.json", _params) do
    %{data: %{message: "telephone_call.json"}}
  end

  def render("telephone_bill.json", _params) do
    %{data: %{message: "telephone_bill.json"}}
  end

end
