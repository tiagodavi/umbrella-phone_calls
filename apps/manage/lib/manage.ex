defmodule Manage do
  @moduledoc false

  alias Manage.Models.TelephoneCall

  def show_telephone_bill(params) do
    {:error, "Something wrong happend"}
  end

  def create_telephone_call(%{"type" => "start"} = params) do
    TelephoneCall.create_call_start(params)
  end

  def create_telephone_call(%{"type" => "end"} = params) do
    TelephoneCall.create_call_end(params)
  end

  def create_telephone_call(_) do
    {:error, "Invalid Type"}
  end
end
