# asynchronous, not replying to the server

defmodule SimpleQueue2 do
  use GenServer

  def init(state), do: {:ok, state}

  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end

  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}

  def handle_call(:queue, _from, state), do: {:reply, state, state}

  # remember, cast will never reply. only call does.
  def handle_cast({:enqueue, value}, state) do
    {:noreply, state ++ [value]} # adding the value to the end of the list (from state aka queue). Like queue is 1,2,3 - dequeue(5), then its adding 1,2,3,5
  end

  ## Client api / function helper

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def queue, do: GenServer.call(__MODULE__, :queue)
  def enqueue(value), do: GenServer.cast(__MODULE__, {:enqueue, value})
  def dequeue, do: GenServer.call(__MODULE__, :dequeue)
end

# SimpleQueue2.start_link([1,2,3])
# SimpleQueue2.queue
# => [1,2,3]
# SimpleQueue2.dequeue(5)
# SimpleQueue2.dequeue

# => [1,2,3,5]