defmodule Exlivery.Users.CreateOrUpdate do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  def call(%{address: address, age: age, cpf: cpf, email: email, name: name}) do
    name
    |> User.build(email, cpf, age, address)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)

    {:ok, "User created or updated successfully"}
  end

  defp save_user({:error, _reason} = error), do: error
end
