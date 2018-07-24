defmodule Manage.Schemas.PriceRules do
  @rules %{
    1 => %{
      standing_charge: 0.36,
      rules: [
        %{from: ~T[06:00:00.000], to: ~T[22:00:00.000], charge: 0.09},
        %{from: ~T[22:00:00.000], to: ~T[06:00:00.000], charge: 0.00}
      ]
    }
  }

  def standing_charge(id) do
    @rules[id][:standing_charge]
  end

  def rules(id) do
    @rules[id][:rules]
  end
end
