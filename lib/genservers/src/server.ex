defmodule Stack do
  use GenServer

  # client

  # using guards (when)
  def start_link(default) when is_list(default) do
    GenServer.start_link(__MODULE__, default)
  end

  # cast does not receive messages
  def push(pid, element) do
  GenServer.cast(pid, {:push, element})
  end

  # defining :pop for the GenServer_call
  def pop(pid) do
  GenServer.call(pid, :pop)
  end

  # Server callbacks
  @impl true
  def init(stack) do
    {:ok, stack}
  end

  # does receive messages
  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  # does not receive messages
  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end
end

# to start this, simply do the following in the iex console
# {:ok, _} = GenServer.start_link(Stack, [:hello], name: MyStack
# GenServer.call(MyStack, :pop)
