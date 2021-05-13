defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Order

  import Exlivery.Factory

  describe "save/1" do
    test "save the order" do
      order = build(:order)

      OrderAgent.start_link(%{})

      response = OrderAgent.save(order)

      assert {:ok, _uuid} = response
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(%{})

      :ok
    end

    test "get the order when the cpf is valid" do
      {:ok, uuid} =
        :order
        |> build()
        |> OrderAgent.save()

      expected_response = {:ok, build(:order)}

      response = OrderAgent.get(uuid)

      assert response == expected_response
    end

    test "get the error when the cpf is invalid" do
      uuid = "banana"

      response = OrderAgent.get(uuid)

      assert response == {:error, "Order not found"}
    end
  end
end
