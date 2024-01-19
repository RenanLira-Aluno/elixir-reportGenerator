defmodule Parser do
  def build_file(filename) do
    "reports/#{filename}.csv"
    |> File.stream!()
    |> Stream.map(&parse_line/1)
  end

  defp parse_line(line) do
    [id, pedido, valor] =
      line
      |> String.trim()
      |> String.split(",")
      |> List.update_at(2, &String.to_integer/1)

    %{id: id, pedido: pedido, valor: valor}
  end
end
