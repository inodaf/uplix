defmodule Uplix.MixProject do
  use Mix.Project

  def project do
    [
      app: :uplix,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:cowboy, :plug, :ex_aws, :ex_aws_s3, :hackney],
      extra_applications: [:logger],
      mod: {Uplix, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:hackney, "~> 1.9"},
      {:plug, "~> 1.0"},
      {:poison, "~> 3.0"},
      {:ex_aws, "~> 2.0"},
      {:ex_aws_s3, "~> 2.0"},
      {:sweet_xml, "~> 0.6"}
    ]
  end
end
