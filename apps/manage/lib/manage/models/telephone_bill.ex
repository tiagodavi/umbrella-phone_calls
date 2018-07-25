defmodule Manage.Models.TelephoneBill do
  @moduledoc false
  import Ecto.Query, warn: false
  alias Manage.Schemas.{TelephoneBill, PriceRules}
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
    case TelephoneCall.info(attrs["phone_number"], attrs["period"]) do
      [_ | _] = data -> {:ok, Enum.map(data, &build_data/1)}
      _ -> {:error, "There is no report for this arguments"}
    end
  end

  defp build_data(data) do
    %{
      destination: data.destination,
      call_start_date: NaiveDateTime.to_date(data.call_start),
      call_start_time: NaiveDateTime.to_time(data.call_start),
      call_duration: build_duration(data.call_start, data.call_end),
      call_price: build_price(data.call_start, data.call_end, data.rule_id)
    }
  end

  defp build_duration(call_start, call_end) do
    {hour, min, sec, _} = build_time(call_start, call_end)
    "#{hour}h#{min}m#{sec}s"
  end

  defp build_price(call_start, call_end, rule_id) do
    {hour, min, _, _} = build_time(call_start, call_end)
    standing_charge = PriceRules.standing_charge(rule_id)

    rule =
      Enum.find(PriceRules.rules(rule_id), fn rule ->
        a = Time.compare(call_start, rule.from)
        b = Time.compare(call_start, rule.to)
        a in [:eq, :gt] && b in [:eq, :lt]
      end)

    Float.round(standing_charge + min * rule.charge + hour * 60 * rule.charge, 2)
  end

  defp build_time(call_start, call_end) do
    secs = NaiveDateTime.diff(call_end, call_start)

    %Timex.Duration{megaseconds: 0, seconds: secs, microseconds: 0}
    |> Timex.Duration.to_clock()
  end
end
