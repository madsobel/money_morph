defmodule MoneyMorphWeb.ApiController do
  use MoneyMorphWeb, :controller

  @default_base "USD"

  alias MoneyMorph.Helpers.AmountParser
  alias MoneyMorphWeb.Presenters.CurrencyPresenter

  def latest(conn, params) do
    base = base_currency(params)
    limit = symbol_limit(params)

    case configured_rates_store().get_rates(base, limit) do
      {:ok, {base, rates}} ->
        conn
        |> render(:latest, base: base, rates: rates)

      {:error, _} ->
        conn
        |> put_status(:not_found)
        |> render(:not_found)
    end
  end

  def currencies(conn, _params) do
    with {:ok, {_, rates}} <- configured_rates_store().get_rates(@default_base) do
      currencies =
        Enum.reduce(rates, %{}, fn {currency, _rate}, acc ->
          Map.put(acc, currency, CurrencyPresenter.currency_name(currency))
        end)

      json(conn, currencies)
    end
  end

  def convert(conn, %{"amount" => amount, "from" => from, "to" => to}) do
    case configured_rates_store().get_rates(from, [to]) do
      {:ok, {^from, rates}} ->
        case AmountParser.parse_value(amount) do
          {:ok, amount} ->
            rate = Map.get(rates, to)
            converted_amount = amount * rate

            conn
            |> render(:convert,
              amount: amount,
              from: from,
              to: to,
              converted_amount: converted_amount,
              rate: rate
            )

          {:error, :invalid_amount} ->
            conn
            |> put_status(:bad_request)
            |> render(:invalid_amount)
        end

      {:error, _} ->
        conn
        |> put_status(:bad_request)
        |> render(:invalid_currency)
    end
  end

  defp base_currency(%{"base" => base}), do: base
  defp base_currency(%{}), do: @default_base

  defp symbol_limit(%{"symbols" => symbols}) do
    String.split(symbols, ",")
  end

  defp symbol_limit(%{}), do: []

  defp configured_rates_store do
    Application.get_env(:money_morph, :rates_store)[:module]
  end
end
