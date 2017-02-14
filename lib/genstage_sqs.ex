defmodule GenstageSqs do
  use Supervisor
  @queue_name "<your_sqs_queue>"

  def start(_, _) do
    Supervisor.start_link(__MODULE__, [], [])
  end

  def init(_) do
    children = [
      worker(
        SQSProducer,
        [@queue_name, [name: :producer1]],
        [id: "Producer.1"]
      ),
      worker(
        SQSProducer,
        [@queue_name, [name: :producer2]],
        [id: "Producer.2"]
      ),
      worker(SQSConsumer, [@queue_name, [:producer1, :producer2]], [id: "Consumer.1"]),
      worker(SQSConsumer, [@queue_name, [:producer1, :producer2]], [id: "Consumer.2"]),
      worker(SQSConsumer, [@queue_name, [:producer1, :producer2]], [id: "Consumer.3"]),
      worker(SQSConsumer, [@queue_name, [:producer1, :producer2]], [id: "Consumer.4"]),
    ]

    supervise(children, strategy: :one_for_one)
  end

  @doc """
  creates {number} of random messages and writes them to the SQS queue.
  """
  def create_messages(number, queue \\ @queue_name)
  def create_messages(number, queue) when is_integer(number) and number >= 1 do
    create_messages(1..number, queue)
  end
  def create_messages(number, queue) do
    Enum.map(number, &make_message/1)
    |> Enum.chunk(10,10)
    |> Enum.each(&(send_messages(&1, queue)))
  end

  defp make_message(num) do
    [id: UUID.uuid4(), message_body: "{'id':#{num}}"]
  end

  defp send_messages(messages, queue) do
    queue
    |> ExAws.SQS.send_message_batch(messages)
    |> ExAws.request
  end
end
