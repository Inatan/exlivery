defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "when all params are valid, returns the user" do
      response = User.build("Ina", "ina@ina.com", "12312312354", 27, "Rua das bananeiras")

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when has a invalid params, returns the erro" do
      response = User.build("Inatan", "ina@ininha.com", "12312312325", 8, "Rua das bananeiras")

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
