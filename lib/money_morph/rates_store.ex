defmodule MoneyMorph.RatesStore do
  use GenServer

  alias MoneyMorph.Calculator
  alias MoneyMorph.Providers.ECB

  @table_name :rates

  def start_link(opts) do
    {name, _opts} = Keyword.pop(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, %{}, name: name)
  end

  def get_rates(currency, limit \\ []) do
    GenServer.call(__MODULE__, {:get_rates, currency, limit})
  end

  @impl GenServer
  def init(_state) do
    {:ok, perform_refresh()}
  end

  @impl GenServer
  def handle_call({:get_rates, currency, limit}, _from, state) do
    case :ets.lookup(@table_name, currency) do
      [] -> {:reply, {:error, :not_found}, state}
      [rates] -> {:reply, {:ok, maybe_limit_rates(rates, limit)}, state}
    end
  end

  defp perform_refresh do
    delete_ets_table()
    create_ets_table()
    fill_ets_table()
  end

  defp delete_ets_table do
    if :ets.whereis(@table_name) != :undefined do
      :ets.delete(@table_name)
    end
  end

  defp create_ets_table do
    :ets.new(@table_name, [:set, :protected, :named_table])
  end

  defp fill_ets_table do
    rates =
      ECB.fetch_rates()
      |> Calculator.calculate_all_rates()

    Enum.each(rates, fn {base, rates} ->
      :ets.insert(@table_name, {base, rates})
    end)
  end

  defp maybe_limit_rates({base, rates}, limit) do
    case limit do
      [] -> {base, rates}
      _ -> {base, Map.take(rates, limit)}
    end
  end
end
