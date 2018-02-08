# GenstageSqs

This is a simple example of using AWS Simple Queue Service (SQS) as the source for a `GenStage` producer. This elixir app creates 2 producers and 4 consumers, reads messages from the queue and then deletes them. It is a very simple and generic example used only to test the functionality of the producer.

You can read about this in my blog post [Writing a GenStage producer for AWS SQS](http://www.tattdcodemonkey.com/blog/2017/2/1/sqs-genstage)


## Testing

To run this example you will need to set the AWS keys as env variables in the command line or add them to the `config/config.exs` instead of the system envs. See ExAws docs for options for configuration.

1. Run `AWS_ACCESS_KEY_ID=your_access_key AWS_SECRET_ACCESS_KEY=your_secret_key iex -S mix`
2. Enter `iex(1)> GenstageSqs.create_messages(10)`

This will cause the producers to start pulling messages from SQS and sending them to the consumers. You can add more of each (producers & consumers) to process more messages or create less to process less messages.
