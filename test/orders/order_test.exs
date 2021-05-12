defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/2" do
    test "when all params are valid, returns the item" do
      items = [
        build(:item),
        build(:item,
          category: :sushi,
          quantity: 5,
          unity_price: Decimal.new("10.0"),
          description: "gohan"
        )
      ]

      user = build(:user)
      response = Order.build(user, items)

      expected_response = {:ok, build(:order)}

      assert response == expected_response
    end

    test "when order has no item, returns the erro" do
      user = build(:user)
      response = Order.build(user, [])

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    # test "when has a invalid price, returns the erro" do
    #   response = Item.build("Pizza peperone", :pizza, "aaa", 1)

    #   expected_response = {:error, "Invalid parameters"}

    #   assert response == expected_response
    # end

    # test "when has a invalid quantity, returns the erro" do
    #   response = Item.build("Pizza peperone", :pizza, "35.5", 0)

    #   expected_response = {:error, "Invalid parameters"}

    #   assert response == expected_response
    # end
  end
end
