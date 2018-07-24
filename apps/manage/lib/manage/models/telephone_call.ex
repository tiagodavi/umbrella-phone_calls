defmodule Manage.Models.TelephoneCall do
  @moduledoc false
  import Ecto.Query, warn: false
  alias Manage.Repo
  alias Manage.Schemas.TelephoneCall

  def create_call_start(attrs) do
    create_call(attrs, &TelephoneCall.call_start_changeset/2)
  end

  def create_call_end(attrs) do
    create_call(attrs, &TelephoneCall.call_end_changeset/2)
  end

  defp create_call(attrs, changeset_fn) do
    %TelephoneCall{}
    |> changeset_fn.(attrs)
    |> Repo.insert()
  end

  def info(phone_number) do
    query =
      from(
        t0 in TelephoneCall,
        join: t1 in TelephoneCall,
        on: t0.call_id == t1.call_id,
        select: %{
          destination: t0.destination,
          call_start: t0.timestamp,
          call_end: t1.timestamp
        },
        where: t0.source == ^phone_number,
        where: t0.type == "start",
        where: t1.type == "end"
      )

    Repo.all(query)
  end
end
