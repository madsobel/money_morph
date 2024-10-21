defmodule MoneyMorphWeb.ApiJSON do
  def latest(%{base: base, rates: rates}) do
    %{
      timestamp: timestamp(),
      base: base,
      rates: rates
    }
  end

  def convert(%{
        amount: amount,
        from: from,
        to: to,
        converted_amount: converted_amount,
        rate: rate
      }) do
    %{
      request: %{
        query: "/convert/#{amount}/#{from}/#{to}",
        amount: amount,
        from: from,
        to: to
      },
      meta: %{
        timestamp: timestamp(),
        rate: rate
      },
      response: converted_amount
    }
  end

  def not_found(_) do
    %{
      error: true,
      status: 404,
      message: "not_found"
    }
  end

  def invalid_amount(_) do
    %{
      error: true,
      status: 400,
      message: "invalid_amount"
    }
  end

  def invalid_currency(_) do
    %{
      error: true,
      status: 400,
      message: "invalid_currency"
    }
  end

  defp timestamp do
    System.os_time(:second)
  end
end
