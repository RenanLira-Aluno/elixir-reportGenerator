defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "generate report" do
      config = %{
        entry: "report_test",
        output: %{
          "foods" => %{
            "açaí" => 1,
            "churrasco" => 2,
            "esfirra" => 3,
            "hambúrguer" => 2,
            "pizza" => 2
          },
          "users" => %{
            "1" => 48,
            "10" => 36,
            "2" => 45,
            "3" => 31,
            "4" => 42,
            "5" => 49,
            "6" => 18,
            "7" => 27,
            "8" => 25,
            "9" => 24
          }
        }
      }

      response = ReportsGenerator.build(config.entry)

      assert response == config.output
    end
  end

  describe "maior_valor_item/2" do
    test "usuario que mais consumiu" do
      config = %{
        entry: "users",
        output: {:ok, {"5", 49}}
      }

      response =
        "report_test"
        |> ReportsGenerator.build()
        |> ReportsGenerator.maior_valor_item(config.entry)

      assert response == config.output
    end

    test "comida mais pedida" do
      config = %{
        entry: "foods",
        output: {:ok, {"esfirra", 3}}
      }

      response =
        "report_test"
        |> ReportsGenerator.build()
        |> ReportsGenerator.maior_valor_item(config.entry)

      assert response == config.output
    end

    test "error opcao invalida" do
      config = %{
        entry: "invalid",
        output: {:error, "Invalid option"}
      }

      response =
        "report_test"
        |> ReportsGenerator.build()
        |> ReportsGenerator.maior_valor_item(config.entry)

      assert response == config.output
    end
  end

  describe "build_from_many/1" do
    test "gerando relatorio de uma lista de arquivos" do
      config = %{
        entry: ["report_test"],
        output: {
          :ok,
          %{
            "foods" => %{
              "açaí" => 1,
              "churrasco" => 2,
              "esfirra" => 3,
              "hambúrguer" => 2,
              "pizza" => 2
            },
            "users" => %{
              "1" => 48,
              "10" => 36,
              "2" => 45,
              "3" => 31,
              "4" => 42,
              "5" => 49,
              "6" => 18,
              "7" => 27,
              "8" => 25,
              "9" => 24
            }
          }
        }
      }

      response = ReportsGenerator.build_from_many(config.entry)

      assert response == config.output
    end

    test "error parametro invalido" do
      config = %{
        entry: "report_test",
        output: {:error, "passe uma lista de nomes"}
      }

      response = ReportsGenerator.build_from_many(config.entry)

      assert response == config.output
    end
  end
end
