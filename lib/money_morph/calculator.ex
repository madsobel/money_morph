defmodule MoneyMorph.Calculator do
  def calculate_all_rates(rates) do
    currencies = Enum.map(rates, & &1.currency)

    Enum.reduce(currencies, %{}, fn base, acc ->
      Map.put(acc, base, calculate_rates_for_base(rates, base))
    end)
  end

  defp calculate_rates_for_base(rates, base_currency) do
    base_rate = Enum.find(rates, &(&1.currency == base_currency)).rate

    Enum.reduce(rates, %{}, fn target, acc ->
      if target.currency != base_currency do
        Map.put(acc, target.currency, calculate_rate_for_base(base_rate, target))
      else
        acc
      end
    end)
  end

  defp calculate_rate_for_base(base_rate, target) do
    target_rate = target.rate
    converted_rate = target_rate / base_rate
    Float.round(converted_rate, 4)
  end
end
