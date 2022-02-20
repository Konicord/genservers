# this is a synchronous genserver | accepting reply from server.

defmodule SimpleQueue do
  use GenServer

  # APi
  def init(state), do: {:ok, state}

  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end

  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}

  def handle_call(:queue, _from, state), do: {:reply, state, state}

  # client api / functions of the helper
  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def queue, do: GenServer.call(__MODULE__, :queue)
  def dequeue, do: GenServer.call(__MODULE__, :dequeue)
end

# SimpleQueue.start_link([1,2,3])
# SimpleQueue.dequeue [1]
# SimpleQueue.dequeue [2]
# SimpleQueue.queue => [3]