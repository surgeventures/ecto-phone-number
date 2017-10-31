defmodule EctoPhoneNumber.Mixfile do
  use Mix.Project

  def project do
    [app: :ecto_phone_number,
     version: "0.1.0",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
     aliases: aliases(),
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: [
       check: :test,
       coveralls: :test,
       "coveralls.detail": :test,
       "coveralls.html": :test],
     name: "EctoPhoneNumber",
     description: "Phone number type with validation and formatting for Ecto",
     source_url: "https://github.com/surgeventures/ecto-phone-number",
     homepage_url: "https://github.com/surgeventures/ecto-phone-number",
     docs: [main: "readme",
            extras: ["README.md"]]]
  end

  defp package do
    [maintainers: ["Karol Słuszniak"],
     licenses: ["MIT"],
     links: %{
       "GitHub" => "https://github.com/surgeventures/ecto-phone-number",
     },
     files: ~w(mix.exs lib LICENSE.md README.md)]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp aliases do
    [
      "check": check_alias(),
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.8.1", only: [:dev, :test]},
      {:ecto, ">= 2.0.0"},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:excoveralls, "~> 0.7", only: :test},
      {:ex_phone_number, github: "surgeventures/ex_phone_number", tag: "v0.1"},
    ]
  end

  defp check_alias do
    [
      "compile --warnings-as-errors --force",
      "test",
      "credo --strict",
    ]
  end
end
