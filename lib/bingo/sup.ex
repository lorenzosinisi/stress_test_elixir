defmodule WriteBuffer do
  use GenServer
  require Logger
  # Client APIs

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  @impl true
  def init(state) do
    {:ok, state, {:continue, :more_init}}
  end

  @impl true
  def handle_info(:attack, state) do
    attack(state)
    {:noreply, state}
  end

  @impl true
  def handle_info({ref, :ok}, state) when is_reference(ref) do
    {:noreply, state}
  end

  @impl true
  def handle_info(_, state) do
    {:noreply, state}
  end

  # New callback
  @impl true
  def handle_continue(:more_init, state) do
    Process.flag(:trap_exit, true)

    if state.every > 0 do
      :timer.send_interval(state.every, self(), :attack)
    end

    attack(state)

    {:noreply, state}
  end

  defp attack(state) do
    Task.async(fn ->
      :timer.sleep(500)

      case Tesla.get(state.url, query: [], recv_timeout: 1_000) do
        {:ok, res} ->
          IO.puts("#{inspect(self())} #{inspect({state.url, inspect(self()), res.status})}")

        {:error, error} ->
          IO.puts("#{inspect(self())} error #{error}")
      end
    end)
  end
end
