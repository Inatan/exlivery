defmodule Exlivery.Orders.Order do
  alias Exlivery.Users.User
  alias Exlivery.Orders.Item
  @keys [:user_cpf, :delivery_address, :items, :total_price]
  @enforce_keys @keys

  defstruct @keys

  def build(%User{cpf: cpf, address: address}, [%Item{} | items] = items) do
    {:ok,
     %__MODULE__{
       user_cpf: cpf,
       delivery_address: address,
       items: items,
       total_price: calculete_total_price(items)
     }}
  end

  def build_item(_user, _items), do: {:error, "Invalid parameters"}

  defp calculete_total_price(items),
    do: Enum.reduce(items, Decimal.new("0.00"), fn item, acc -> sum_prices(item, acc) end)

  defp sum_prices(%Item{unity_price: price, quantity: quantity}, acc) do
    price
    |> Decimal.mult(quantity)
    |> Decimal.add(acc)
  end
end
