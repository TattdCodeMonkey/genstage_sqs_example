# GenstageSqs

This is a simple example of using AWS Simple Queue Service (SQS) as the source for a `GenStage` producer. This elixir app creates 2 producers and 4 consumers, reads messages from the queue and then deletes them. It is a very simple and generic example used only to test the functionality of the producer.

You can read about this in my blog post [Writing a GenStage producer for AWS SQS](http://www.tattdcodemonkey.com/blog/2017/2/1/sqs-genstage)
