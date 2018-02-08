# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# set your queue name, do not set the domain (i.e: "111111111/your-sqs-name")
config :genstage_sqs, :queue_name, System.get_env("SQS_QUEUE_NAME") || "<your_sqs_queue>"

config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role]
