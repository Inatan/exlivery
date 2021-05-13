defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "save the user" do
      params = %{
        address: "Rua das bananeiras",
        age: 27,
        cpf: "12312312354",
        email: "ina@ina.com",
        name: "Ina"
      }

      response = Exlivery.create_or_update_user(params)

      assert response == {:ok, "User created or updated successfully"}
    end

    test "return error with invalid user" do
      params = %{
        address: "Rua das bananeiras",
        age: 8,
        cpf: "12312312354",
        email: "ina@ina.com",
        name: "Ina"
      }

      response = Exlivery.create_or_update_user(params)

      assert response == {:error, "Invalid parameters"}
    end
  end
end
