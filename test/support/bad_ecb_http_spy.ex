defmodule MoneyMorph.BadECBHttpSpy do
  def get("https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml") do
    {:ok, %{status: 500, body: ""}}
  end
end
