defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "build/4" do
    test "when all params are valid, returns the item" do
      response = Item.build("Pizza peperone", :pizza, "35.5", 1)

      expected_response = {:ok, build(:item)}

      assert response == expected_response
    end

    test "when has a invalid category, returns the erro" do
      response = Item.build("Pizza peperone", :aba, "35.5", 1)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "when has a invalid price, returns the erro" do
      response = Item.build("Pizza peperone", :pizza, "aaa", 1)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "when has a invalid quantity, returns the erro" do
      response = Item.build("Pizza peperone", :pizza, "35.5", 0)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
