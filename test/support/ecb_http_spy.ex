defmodule MoneyMorph.ECBHttpSpy do
  def get("https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml" = url) do
    send(:http_spy_handler, {:get, url})

    response_body =
      __DIR__
      |> Path.join("eurofxref-daily.xml")
      |> File.read!()

    {:ok, %{status: 200, body: response_body}}
  end
end
