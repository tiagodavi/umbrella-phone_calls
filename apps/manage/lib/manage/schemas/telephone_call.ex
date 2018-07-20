defmodule Manage.Schemas.TelephoneCall do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "telephone_calls" do
    field(:type, :string)
    field(:timestamp, :naive_datetime)
    field(:call_id, :integer)
    field(:source, :string)
    field(:destination, :string)
    timestamps()
  end

  def call_start_changeset(telephone_call, attrs) do
    telephone_call
    |> cast(attrs, [:type, :timestamp, :call_id, :source, :destination])
    |> validate_required([:type, :timestamp, :call_id, :source, :destination])
    |> validate_format(:source, ~r/^[0-9]{11}$/)
    |> validate_format(:destination, ~r/^[0-9]{11}$/)
    |> validate_source_destination
  end

  def call_end_changeset(telephone_call, attrs) do
    telephone_call
    |> cast(attrs, [:type, :timestamp, :call_id])
    |> validate_required([:type, :timestamp, :call_id])
  end

  defp validate_source_destination(changeset) do
    source = get_change(changeset, :source)
    destination = get_change(changeset, :destination)

    case source do
      ^destination -> add_error(changeset, :numbers, "phone numbers are the same")
      _ -> changeset
    end
  end
end
