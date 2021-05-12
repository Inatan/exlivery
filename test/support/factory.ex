defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User
  alias Exlivery.Orders.{Item, Order}

  def user_factory do
    %User{
      name: "Ina",
      email: "ina@ina.com",
      cpf: "12312312354",
      age: 27,
      address: "Rua das bananeiras"
    }
  end

  def item_factory do
    %Item{
      description: "Pizza peperone",
      category: :pizza,
      unity_price: Decimal.new("35.5"),
      quantity: 1
    }
  end

  def order_factory do
    %Order{
      delivery_address: "Rua das bananeiras",
      items: [
        build(:item),
        build(:item,
          category: :sushi,
          quantity: 5,
          unity_price: Decimal.new("10.0"),
          description: "gohan"
        )
      ],
      total_price: Decimal.new("85.50"),
      user_cpf: "12312312354"
    }
  end
end
