defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "create the report file" do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      expected_response =
        {:ok,
         "12312312354,pizza,1,35.5,sushi,5,10.0,85.50\n" <>
           "12312312354,pizza,1,35.5,sushi,5,10.0,85.50\n"}

      Report.create("Report_test.csv")

      response = File.read("Report_test.csv")

      assert response == expected_response
    end
  end
end
