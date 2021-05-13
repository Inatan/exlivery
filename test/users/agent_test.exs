defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "save/1" do
    test "save the user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      cpf = "12312312354"

      {:ok, %{cpf: cpf}}
    end

    test "get the user when the cpf is valid", %{cpf: cpf} do
      :user
      |> build(cpf: cpf)
      |> UserAgent.save()

      expected_response = {:ok, build(:user, cpf: cpf)}

      response = UserAgent.get(cpf)

      assert response == expected_response
    end

    test "get the error when the cpf is invalid", %{cpf: cpf} do
      response = UserAgent.get(cpf)

      assert response == {:error, "User not found"}
    end
  end
end
