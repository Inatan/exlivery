defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Order
  alias Exlivery.Users.Agent, as: UserAgent

  import Exlivery.Factory

  describe "call/1" do
    setup do
      Exlivery.start_agents()
      user = build(:user)

      UserAgent.save(user)

      item1 = build(:item)

      item2 =
        build(:item,
          category: :japonesa,
          quantity: 5,
          unity_price: Decimal.new("10.0"),
          description: "gohan"
        )

      {:ok, %{cpf: user.cpf, item1: item1, item2: item2}}
    end

    test "save the order", %{cpf: cpf, item1: item1, item2: item2} do
      items = [item1, item2]
      params = %{user_cpf: cpf, items: items}

      {response, uuid} = Exlivery.create_or_update_order(params)

      assert response == :ok
    end

    test "return error with invalid items", %{cpf: cpf, item1: item1, item2: item2} do
      items = []

      params = %{user_cpf: cpf, items: items}

      response = Exlivery.create_or_update_order(params)

      assert response == {:error, "Invalid parameters"}
    end

    test "return error with a invalid item", %{cpf: cpf, item1: item1, item2: item2} do
      items = [item1, %{item2 | unity_price: "Banana"}]

      params = %{user_cpf: cpf, items: items}

      response = Exlivery.create_or_update_order(params)

      assert response == {:error, "invalid items"}
    end

    test "return error with invalid user", %{cpf: cpf, item1: item1, item2: item2} do
      items = [item1, item2]

      params = %{user_cpf: "111111111111", items: items}

      response = Exlivery.create_or_update_order(params)

      assert response == {:error, "User not found"}
    end
  end
end
