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
end
