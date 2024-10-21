defmodule MoneyMorph.Helpers.AmountParserTest do
  use ExUnit.Case, async: true

  describe "parse_value/1" do
    test "it parses a float value" do
      assert {:ok, 1.0} == MoneyMorph.Helpers.AmountParser.parse_value("1.0")
    end

    test "it parses an integer value" do
      assert {:ok, 1} == MoneyMorph.Helpers.AmountParser.parse_value("1")
    end

    test "it returns an error for an invalid amount" do
      assert {:error, :invalid_amount} == MoneyMorph.Helpers.AmountParser.parse_value("invalid")
    end
  end
end
