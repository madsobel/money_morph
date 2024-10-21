defmodule MoneyMorph.Providers.ECBTest do
  use ExUnit.Case, async: true

  alias MoneyMorph.ExchangeRate
  alias MoneyMorph.Providers.ECB

  def with_spy_handler(_ctx) do
    Process.register(self(), :http_spy_handler)

    :ok
  end

  describe "fetch_rates/0" do
    setup :with_spy_handler

    test "it sends a request and fetches the latest ecb rates" do
      ECB.fetch_rates(MoneyMorph.ECBHttpSpy)

      assert_receive {
        :get,
        "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"
      }
    end

    test "it returns a list of ExchangeRate" do
      response = ECB.fetch_rates(MoneyMorph.ECBHttpSpy)

      assert Enum.all?(response, fn rate -> is_struct(rate, ExchangeRate) end)
    end

    test "it includes a EUR base rate" do
      response = ECB.fetch_rates(MoneyMorph.ECBHttpSpy)

      eur_rate = Enum.find(response, fn rate -> rate.currency == "EUR" end)

      assert eur_rate.rate == 1.0
    end

    test "it returns an empty list when the request fails" do
      response = ECB.fetch_rates(MoneyMorph.BadECBHttpSpy)

      assert response == []
    end
  end
end
