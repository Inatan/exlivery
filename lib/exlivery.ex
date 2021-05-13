defmodule Exlivery do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Users.Agent, as: UserAgent

  alias Exlivery.Orders.CreateOrUpdate, as: OrderCreateOrUpdate
  alias Exlivery.Users.CreateOrUpdate, as: UserCreateOrUpdate

  def start_agents do
    UserAgent.start_link(%{})
    OrderAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params), to: UserCreateOrUpdate, as: :call
  defdelegate create_or_update_order(params), to: OrderCreateOrUpdate, as: :call
end
