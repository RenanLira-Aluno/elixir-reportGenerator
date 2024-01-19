defmodule ReportsGenerator do
  @options [
    "users",
    "foods"
  ]

  def build(filename) do
    filename
    |> Parser.build_file()
    |> Enum.reduce(%{"users" => %{}, "foods" => %{}}, &sum_values/2)
  end

  def build_from_many(filenames) when not is_list(filenames) do
    {:error, "passe uma lista de nomes"}
  end

  def build_from_many(filenames) do
    result =
      filenames
      |> Task.async_stream(&build/1)
      |> Enum.reduce(%{"users" => %{}, "foods" => %{}}, fn {:ok, result}, acc ->
        sum_maps(result, acc)
      end)

    {:ok, result}
  end

  def maior_valor_item(report, option) when option in @options do
    result =
      report[option]
      |> Enum.max_by(fn {_, valor} -> valor end)

    {:ok, result}
  end

  def maior_valor_item(_report, _option), do: {:error, "Invalid option"}

  defp sum_values(%{id: id, pedido: produtos, valor: valor}, %{"users" => users, "foods" => foods}) do
    users = Map.put(users, id, (users[id] || 0) + valor)
    foods = Map.put(foods, produtos, (foods[produtos] || 0) + 1)

    %{"users" => users, "foods" => foods}
  end

  defp sum_maps(map, acc) do
    users =
      Map.merge(acc["users"], map["users"], fn _key, value1, value2 ->
        value1 + value2
      end)

    foods =
      Map.merge(acc["foods"], map["foods"], fn _key, value1, value2 ->
        value1 + value2
      end)

    %{"users" => users, "foods" => foods}
  end
end
