defmodule MoneyMorph.ExchangeRate do
  @enforce_keys [:currency, :rate]
  defstruct [:currency, :rate]
end
