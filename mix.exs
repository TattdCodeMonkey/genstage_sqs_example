defmodule GenstageSqs.Mixfile do
  use Mix.Project

  def project do
    [app: :genstage_sqs,
     version: "0.2.0",
     elixir: "~> 1.5",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [
      registered: [:genstage_sqs],
      mod: {GenstageSqs, []},
      extra_applications: [:logger, :ex_aws, :hackney]
    ]
  end

  defp deps do
    [
      {:ex_aws, "~> 2.0"},
      {:ex_aws_sqs, "~> 2.0"},
      {:poison, "~> 3.0"},
      {:hackney, "~> 1.9"},
      {:sweet_xml, "~> 0.6"},
      {:gen_stage, "~> 0.12"},
      {:uuid, "~> 1.1"},
    ]
  end
end
