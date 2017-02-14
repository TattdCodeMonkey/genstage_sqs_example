defmodule GenstageSqs.Mixfile do
  use Mix.Project

  def project do
    [app: :genstage_sqs,
     version: "0.1.0",
     elixir: "~> 1.4",
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
      {:ex_aws, "~> 1.1.0"},
      {:poison, ">= 1.2.0"},
      {:hackney, "~> 1.6"},
      {:sweet_xml, "~> 0.6"},
      {:gen_stage, "~> 0.11.0"},
      {:uuid, "~> 1.1"},
    ]
  end
end
