defmodule SQSProducer do
  use GenStage

  def start_link(queue_name, opts \\ []) do
    GenStage.start_link(__MODULE__, queue_name, opts)
  end

  def init(queue_name) do
    state = %{
      demand: 0,
      queue: queue_name
    }

    {:producer, state}
  end

  def handle_demand(incoming_demand, %{demand: 0} = state) do
    new_demand = state.demand + incoming_demand

    Process.send(self(), :get_messages, [])

    {:noreply, [], %{state| demand: new_demand}}
  end
  def handle_demand(incoming_demand, state) do
    new_demand = state.demand + incoming_demand

    {:noreply, [], %{state| demand: new_demand}}
  end

  def handle_info(:get_messages, state) do
    aws_resp = ExAws.SQS.receive_message(
      state.queue,
      max_number_of_messages: min(state.demand, 10)
    )
    |> ExAws.request

    messages = case aws_resp do
      {:ok, resp} ->
        resp.body.messages
      {:error, reason} ->
        # You probably want to handle errors differently than this.
        []
    end

    num_messages_received = Enum.count(messages)
    new_demand = max(state.demand - num_messages_received, 0)

    cond do
      new_demand == 0 -> :ok
      num_messages_received == 0 ->
        Process.send_after(self(), :get_messages, 200)
      true ->
        Process.send(self(), :get_messages, [])
    end

    {:noreply, messages, %{state| demand: new_demand}}
  end
end
