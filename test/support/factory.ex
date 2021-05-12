defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User

  def user_factory do
    %User{
      name: "Ina",
      email: "ina@ina.com",
      cpf: "12312312354",
      age: 27,
      address: "Rua das bananeiras"
    }
  end
end
