defmodule ApiWeb.Api.V1.TelephoneSystemView do
  use ApiWeb, :view

  def render("telephone_call.json", %{data: data}) do
    %{
      data: %{
        type: data.type,
        id: data.id,
        call_id: data.call_id,
        source: data.source,
        destination: data.destination,
        timestamp: data.timestamp
      }
    }
  end

  def render("telephone_bill.json", data) do
    %{data: data}
  end
end
