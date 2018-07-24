defmodule Manage.Schemas.TelephoneBill do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:phone_number, :string)
    field(:period, :string)
  end

  def changeset(telephone_bill, attrs) do
    telephone_bill
    |> cast(attrs, [:phone_number, :period])
    |> validate_required([:phone_number])
    |> validate_format(:phone_number, ~r/^[0-9]{10,11}$/)
    |> validate_format(:period, ~r/^[0-9]{1,2}\/[0-9]{4}$/)
  end
end
