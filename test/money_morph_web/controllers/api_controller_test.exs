defmodule MoneyMorphWeb.ApiControllerTest do
  use MoneyMorphWeb.ConnCase, async: true

  describe "GET /api/latest" do
    test "it returns the latest rates for the default base currency", %{conn: conn} do
      conn = get(conn, ~p"/api/latest")
      json_response = json_response(conn, 200)

      assert json_response["base"] == "USD"
      assert length(Map.keys(json_response["rates"])) == 31
    end

    test "it returns the latest rates for the specified base currency", %{conn: conn} do
      conn = get(conn, ~p"/api/latest?base=EUR")
      json_response = json_response(conn, 200)

      assert json_response["base"] == "EUR"
      assert length(Map.keys(json_response["rates"])) == 31
    end

    test "it returns a 404 when the base currency is not found", %{conn: conn} do
      conn = get(conn, ~p"/api/latest?base=ZZZ")
      json_response = json_response(conn, 404)

      assert json_response == %{
               "error" => true,
               "message" => "not_found",
               "status" => 404
             }
    end

    test "it includes a timestamp in the response", %{conn: conn} do
      conn = get(conn, ~p"/api/latest")
      json_response = json_response(conn, 200)

      refute is_nil(json_response["timestamp"])
    end

    test "it supports limiting the returned rates by specifying a list of symbols", %{conn: conn} do
      conn = get(conn, ~p"/api/latest?symbols=EUR,GBP")
      json_response = json_response(conn, 200)

      assert length(Map.keys(json_response["rates"])) == 2
      assert Map.has_key?(json_response["rates"], "EUR")
      assert Map.has_key?(json_response["rates"], "GBP")
    end
  end

  describe "GET /api/currencies" do
    test "it returns the supported currency names", %{conn: conn} do
      conn = get(conn, ~p"/api/currencies")
      json_response = json_response(conn, 200)

      assert length(Map.keys(json_response)) == 31
      assert Map.has_key?(json_response, "AUD")
      assert Map.get(json_response, "USD") == "United States Dollar"
    end
  end

  describe "GET /api/convert/:amount/:from/:to" do
    test "it returns the converted amount", %{conn: conn} do
      conn = get(conn, ~p"/api/convert/10/USD/EUR")
      json_response = json_response(conn, 200)

      expected_result = 9.2190

      assert_in_delta expected_result, json_response["response"], 0.0001

      assert json_response["request"] == %{
               "amount" => 10.0,
               "from" => "USD",
               "query" => "/convert/10.0/USD/EUR",
               "to" => "EUR"
             }
    end

    test "it returns a 400 when the amount is invalid", %{conn: conn} do
      conn = get(conn, ~p"/api/convert/invalid/USD/EUR")
      json_response = json_response(conn, 400)

      assert json_response == %{
               "error" => true,
               "message" => "invalid_amount",
               "status" => 400
             }
    end

    test "it returns a 400 when the currency is invalid", %{conn: conn} do
      conn = get(conn, ~p"/api/convert/10/USD/ZZZ")
      json_response = json_response(conn, 400)

      assert json_response == %{
               "error" => true,
               "message" => "invalid_currency",
               "status" => 400
             }
    end
  end
end
