defmodule ApiWeb.Api.V1.TelephoneSystemView do
  use ApiWeb, :view
  alias ApiWeb.Api.V1.TelephoneSystemView

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

  def render("telephone_bill.json", %{data: data}) do
    %{data: render_many(data, TelephoneSystemView, "invoice.json", as: :data)}
  end

  def render("invoice.json", %{data: data}) do
    %{
      destination: data.destination,
      call_start_date: data.call_start_date,
      call_start_time: data.call_start_time,
      call_duration: data.call_duration,
      call_price: data.call_price
    }
  end
end
