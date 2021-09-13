defmodule EctoPhoneNumber.Mixfile do
  use Mix.Project

  @name "EctoPhoneNumber"
  @description "Phone number type with validation and formatting for Ecto"
  @github_url "https://github.com/surgeventures/ecto-phone-number"
  @version "0.4.1"

  def project do
    [
      app: :ecto_phone_number,
      name: @name,
      version: @version,
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ],
      deps: deps(),
      package: package(),
      docs: docs()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:credo, "~> 1.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ecto, ">= 2.0.0"},
      {:ex_doc, "~> 0.24.2", only: :dev, runtime: false},
      {:ex_phone_number, "~> 0.2.4", hex: :ex_phone_number_fresha}
    ]
  end

  defp docs do
    [
      extras: [
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @github_url,
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end

  defp package do
    [
      description: @description,
      maintainers: ["Karol Słuszniak"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @github_url
      }
    ]
  end
end
