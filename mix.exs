defmodule EctoPhoneNumber.Mixfile do
  use Mix.Project

  @name "EctoPhoneNumber"
  @description "Phone number type with validation and formatting for Ecto"
  @github_url "https://github.com/surgeventures/ecto-phone-number"

  def project do
    [
      app: :ecto_phone_number,
      version: "0.3.4",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: @name,
      description: @description,
      package: [
        maintainers: ["Karol Słuszniak"],
        licenses: ["MIT"],
        links: %{
          "GitHub" => @github_url
        }
      ],
      docs: [
        main: "readme",
        extras: ["README.md"],
        source_url: @github_url
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:credo, "~> 1.0", only: :dev, runtime: false},
      {:ecto, ">= 2.0.0"},
      {:ex_doc, "~> 0.24.2", only: :dev, runtime: false},
      {:ex_phone_number, "~> 0.2.1"}
    ]
  end
end
