defmodule MoneyMorphWeb.Presenters.CurrencyPresenterTest do
  use ExUnit.Case, async: true

  alias MoneyMorphWeb.Presenters.CurrencyPresenter

  describe "currency_name/1" do
    test "it presents AUD" do
      assert CurrencyPresenter.currency_name("AUD") == "Australian Dollar"
    end

    test "it presents BGN" do
      assert CurrencyPresenter.currency_name("BGN") == "Bulgarian Lev"
    end

    test "it presents BRL" do
      assert CurrencyPresenter.currency_name("BRL") == "Brazilian Real"
    end

    test "it presents CAD" do
      assert CurrencyPresenter.currency_name("CAD") == "Canadian Dollar"
    end

    test "it presents CHF" do
      assert CurrencyPresenter.currency_name("CHF") == "Swiss Franc"
    end

    test "it presents CNY" do
      assert CurrencyPresenter.currency_name("CNY") == "Chinese Yuan"
    end

    test "it presents CZK" do
      assert CurrencyPresenter.currency_name("CZK") == "Czech Koruna"
    end

    test "it presents DKK" do
      assert CurrencyPresenter.currency_name("DKK") == "Danish Krone"
    end

    test "it presents EUR" do
      assert CurrencyPresenter.currency_name("EUR") == "Euro"
    end

    test "it presents GBP" do
      assert CurrencyPresenter.currency_name("GBP") == "British Pound"
    end

    test "it presents HKD" do
      assert CurrencyPresenter.currency_name("HKD") == "Hong Kong Dollar"
    end

    test "it presents HUF" do
      assert CurrencyPresenter.currency_name("HUF") == "Hungarian Forint"
    end

    test "it presents IDR" do
      assert CurrencyPresenter.currency_name("IDR") == "Indonesian Rupiah"
    end

    test "it presents ILS" do
      assert CurrencyPresenter.currency_name("ILS") == "Israeli Shekel"
    end

    test "it presents INR" do
      assert CurrencyPresenter.currency_name("INR") == "Indian Rupee"
    end

    test "it presents ISK" do
      assert CurrencyPresenter.currency_name("ISK") == "Icelandic Krona"
    end

    test "it presents JPY" do
      assert CurrencyPresenter.currency_name("JPY") == "Japanese Yen"
    end

    test "it presents KRW" do
      assert CurrencyPresenter.currency_name("KRW") == "South Korean Won"
    end

    test "it presents MXN" do
      assert CurrencyPresenter.currency_name("MXN") == "Mexican Peso"
    end

    test "it presents MYR" do
      assert CurrencyPresenter.currency_name("MYR") == "Malaysian Ringgit"
    end

    test "it presents NOK" do
      assert CurrencyPresenter.currency_name("NOK") == "Norwegian Krone"
    end

    test "it presents NZD" do
      assert CurrencyPresenter.currency_name("NZD") == "New Zealand Dollar"
    end

    test "it presents PHP" do
      assert CurrencyPresenter.currency_name("PHP") == "Philippine Peso"
    end

    test "it presents PLN" do
      assert CurrencyPresenter.currency_name("PLN") == "Polish Zloty"
    end

    test "it presents RON" do
      assert CurrencyPresenter.currency_name("RON") == "Romanian Leu"
    end

    test "it presents SEK" do
      assert CurrencyPresenter.currency_name("SEK") == "Swedish Krona"
    end

    test "it presents SGD" do
      assert CurrencyPresenter.currency_name("SGD") == "Singapore Dollar"
    end

    test "it presents THB" do
      assert CurrencyPresenter.currency_name("THB") == "Thai Baht"
    end

    test "it presents TRY" do
      assert CurrencyPresenter.currency_name("TRY") == "Turkish Lira"
    end

    test "it presents USD" do
      assert CurrencyPresenter.currency_name("USD") == "United States Dollar"
    end

    test "it presents ZAR" do
      assert CurrencyPresenter.currency_name("ZAR") == "South African Rand"
    end
  end
end
