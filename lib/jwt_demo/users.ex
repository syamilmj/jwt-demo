defmodule JwtDemo.Users do
  use GenServer

  # API

  def start_link(_) do
    GenServer.start_link(__MODULE__, [],
      name: __MODULE__,
      strategy: :one_for_one
    )
  end

  def get(id) do
    GenServer.call(__MODULE__, {:get, id})
  end

  # CALLBACKS

  def init(_) do
    :ets.new(:users, [:set, :protected, :named_table])
    create_users()
    {:ok, []}
  end

  def handle_call({:get, id}, _, state) do
    user =
      case :ets.lookup(:users, id) do
        [{_key, user}] ->
          user

        _ ->
          nil
      end

    {:reply, user, state}
  end

  # HELPERS

  defp create_users() do
    [
      %{id: 1, name: "Thomas"},
      %{id: 2, name: "Claire"}
    ]
    |> Enum.each(fn user ->
      :ets.insert(:users, {user.id, user})
    end)
  end
end
