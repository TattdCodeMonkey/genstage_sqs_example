defmodule SQSConsumer do
  use GenStage
  alias ExAws.SQS

  def start_link(queue_name, producers, opts \\ []) do
    GenStage.start_link(__MODULE__, [queue: queue_name, producers: producers], opts)
  end

  def init([queue: queue_name, producers: producers]) do
    state = %{
      queue: queue_name
    }

    subscriptions = Enum.map(producers, &({&1, [max_demand: 10]}))
    {:consumer, state, subscribe_to: subscriptions}
  end

  def handle_events(messages, _from, state) do
    handle_messages(messages, state)
    {:noreply, [], state}
  end

  defp handle_messages(messages, state) do
    ## You probably want to handle errors or issues by NOT deleting
    ## those messages, but this is fine for our example
    Enum.each(messages, &process_message/1)

    state.queue
    |> SQS.delete_message_batch(Enum.map(messages, &make_batch_item/1))
    |> ExAws.request
  end

  defp make_batch_item({:ok, message}) do
    %{id: Map.get(message, :message_id), receipt_handle: Map.get(message, :receipt_handle)}
  end

  defp process_message(message) do
    ## Do something to process message here
    {:ok, message}
  end

end
