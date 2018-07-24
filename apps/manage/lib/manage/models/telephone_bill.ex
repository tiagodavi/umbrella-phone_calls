defmodule Manage.Models.TelephoneBill do
  @moduledoc false
  import Ecto.Query, warn: false
  alias Manage.Repo
  alias Manage.Schemas.TelephoneBill
  alias Manage.Models.TelephoneCall

  def report(attrs) do
    changeset =
      %TelephoneBill{}
      |> TelephoneBill.changeset(attrs)

    if changeset.valid? do
      build_report(attrs)
    else
      {:error, changeset}
    end
  end

  defp build_report(attrs) do
    IO.inspect(attrs)

    case TelephoneCall.info(attrs["phone_number"]) do
      [_ | _] = data -> {:ok, Enum.map(data, &build_data/1)}
      _ -> {:error, "Phone number has not been found"}
    end
  end

  defp build_data(data) do
    %{
      destination: data.destination,
      call_start_date: NaiveDateTime.to_date(data.call_start),
      call_start_time: NaiveDateTime.to_time(data.call_start),
      call_duration: build_duration(data.call_start, data.call_end),
      call_price: build_price(data.call_start, data.call_end)
    }
  end

  defp build_duration(call_start, call_end) do
    {hour, min, sec} = build_time(call_start, call_end)
    "#{hour}h#{min}m#{sec}s"
  end

  defp build_price(call_start, call_end) do
    {hour, min, sec} = build_time(call_start, call_end)
    45.50
  end

  defp build_time(call_start, call_end) do
    secs = Time.diff(call_end, call_start)
    :calendar.seconds_to_time(secs)
  end
end
