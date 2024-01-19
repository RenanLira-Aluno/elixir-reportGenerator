defmodule ParserTest do
  use ExUnit.Case

  describe "parse_file/1" do
    test "parse the file" do
      config = %{
        entry: "report_test",
        output: [
          %{id: "1", pedido: "pizza", valor: 48},
          %{id: "2", pedido: "açaí", valor: 45},
          %{id: "3", pedido: "hambúrguer", valor: 31},
          %{id: "4", pedido: "esfirra", valor: 42},
          %{id: "5", pedido: "hambúrguer", valor: 49},
          %{id: "6", pedido: "esfirra", valor: 18},
          %{id: "7", pedido: "pizza", valor: 27},
          %{id: "8", pedido: "esfirra", valor: 25},
          %{id: "9", pedido: "churrasco", valor: 24},
          %{id: "10", pedido: "churrasco", valor: 36}
        ]
      }

      response =
        config.entry
        |> Parser.build_file()
        |> Enum.map(& &1)

      assert response == config.output
    end
  end
end
