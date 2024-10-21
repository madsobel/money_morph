defmodule MoneyMorph.Helpers.AmountParser do
  def parse_value(value) when is_binary(value) do
    cond do
      float_value = parse_float(value) ->
        {:ok, float_value}

      integer_value = parse_integer(value) ->
        {:ok, integer_value}

      true ->
        {:error, :invalid_amount}
    end
  end

  defp parse_float(value) do
    case Float.parse(value) do
      {float, ""} -> float
      _ -> nil
    end
  end

  defp parse_integer(value) do
    case Integer.parse(value) do
      {integer, ""} -> integer
      _ -> nil
    end
  end
end
