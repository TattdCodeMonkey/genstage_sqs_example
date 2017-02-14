# GenstageSqs

This is a simple example of using AWS Simple Queue Service (SQS) as the source for a `GenStage` producer. This elixir app creates 2 producers and 4 consumers, reads messages from the queue and then deletes them. It is a very simple and generic example used only to test the functionality of the producer.

You can read about this in my blog post [Writing a GenStage producer for AWS SQS](http://www.tattdcodemonkey.com/blog/2017/2/1/sqs-genstage)


## Testing

To run this example you will need to set the AWS keys as env variables or add them to the congis.exs. See ExAws docs for options for configuration. You will also need to set the `@queue_name` variables in `genstage_sqs.ex`.

Then run `iex -S mix`, this will cause the producers to start pulling messages from SQS and sending them to the consumers. You can add more of each (producers & consumers) to process more messages or create less to process less messages.
