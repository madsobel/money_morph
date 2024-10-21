defmodule MoneyMorph.Providers.ECB do
  @moduledoc """
  European Central Bank provider.
  """

  alias MoneyMorph.ExchangeRate

  @url "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"

  # @behaviour MoneyMorph.Providers

  # @impl MoneyMorph.Providers
  def fetch_rates(http \\ Req) do
    @url
    |> http.get()
    |> handle_response()
    |> parse_rates()
  end

  defp handle_response({:ok, %{status: 200, body: body}}) do
    body
    |> XmlToMap.naive_map()
    |> Map.get("gesmes:Envelope")
    |> Map.get("Cube")
    |> Map.get("Cube")
    |> Map.get("#content")
    |> Map.get("Cube")
  end

  defp handle_response(_) do
    []
  end

  defp parse_rates(rates) do
    rates
    |> Enum.map(&parse_rate/1)
    |> maybe_add_base_rate()
  end

  defp parse_rate(rate) do
    %ExchangeRate{currency: rate["-currency"], rate: String.to_float(rate["-rate"])}
  end

  defp maybe_add_base_rate([]) do
    []
  end

  defp maybe_add_base_rate(rates) do
    [%ExchangeRate{currency: "EUR", rate: 1.0} | rates]
  end
end
