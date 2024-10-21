defmodule MoneyMorph.TestRatesStore do
  def get_rates("USD") do
    get_rates("USD", [])
  end

  def get_rates("USD", []) do
    {:ok,
     {"USD",
      %{
        "AUD" => 1.4903,
        "BGN" => 1.8031,
        "BRL" => 5.6539,
        "CAD" => 1.3792,
        "CHF" => 0.8667,
        "CNY" => 7.1047,
        "CZK" => 23.259,
        "DKK" => 6.8753,
        "EUR" => 0.9219,
        "GBP" => 0.7667,
        "HKD" => 7.769,
        "HUF" => 368.8117,
        "IDR" => 15491.8042,
        "ILS" => 3.7085,
        "INR" => 84.0767,
        "ISK" => 137.4574,
        "JPY" => 150.0415,
        "KRW" => 1371.854,
        "MXN" => 19.736,
        "MYR" => 4.3045,
        "NOK" => 10.8892,
        "NZD" => 1.647,
        "PHP" => 57.4896,
        "PLN" => 3.9721,
        "RON" => 4.585,
        "SEK" => 10.5287,
        "SGD" => 1.3123,
        "THB" => 33.1852,
        "TRY" => 34.2924,
        "USD" => 1.0,
        "ZAR" => 17.5873
      }}}
  end

  def get_rates("EUR", []) do
    {:ok,
     {"EUR",
      %{
        "AUD" => 1.4903,
        "BGN" => 1.8031,
        "BRL" => 5.6539,
        "CAD" => 1.3792,
        "CHF" => 0.8667,
        "CNY" => 7.1047,
        "CZK" => 23.259,
        "DKK" => 6.8753,
        "EUR" => 0.9219,
        "GBP" => 0.7667,
        "HKD" => 7.769,
        "HUF" => 368.8117,
        "IDR" => 15491.8042,
        "ILS" => 3.7085,
        "INR" => 84.0767,
        "ISK" => 137.4574,
        "JPY" => 150.0415,
        "KRW" => 1371.854,
        "MXN" => 19.736,
        "MYR" => 4.3045,
        "NOK" => 10.8892,
        "NZD" => 1.647,
        "PHP" => 57.4896,
        "PLN" => 3.9721,
        "RON" => 4.585,
        "SEK" => 10.5287,
        "SGD" => 1.3123,
        "THB" => 33.1852,
        "TRY" => 34.2924,
        "USD" => 1.0,
        "ZAR" => 17.5873
      }}}
  end

  def get_rates("USD", ["EUR"]) do
    {:ok,
     {"USD",
      %{
        "EUR" => 0.9219
      }}}
  end

  def get_rates("USD", ["EUR", "GBP"]) do
    {:ok,
     {"USD",
      %{
        "EUR" => 0.9219,
        "GBP" => 0.7667
      }}}
  end

  def get_rates(_, _), do: {:error, :not_found}
end
