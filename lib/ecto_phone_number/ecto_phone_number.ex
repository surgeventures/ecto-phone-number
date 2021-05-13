defmodule EctoPhoneNumber do
  @moduledoc """
  Phone number type with validation and formatting for Ecto.
  """

  @behaviour Ecto.Type

  defstruct [:e164]

  defimpl Inspect do
    def inspect(%{e164: e164}, _opts) do
      ~s(#EctoPhoneNumber<#{e164}>)
    end
  end

  defimpl String.Chars do
    def to_string(phone_number = %{e164: e164}) do
      alias EctoPhoneNumber

      EctoPhoneNumber.format(phone_number) || Kernel.to_string(e164)
    rescue
      ArgumentError -> Kernel.to_string(e164)
    end
  end

  def type, do: :string

  def cast(phone_number = %__MODULE__{}), do: {:ok, phone_number}
  def cast(integer) when is_integer(integer), do: Kernel.to_string(integer) |> cast()

  def cast(string) when is_binary(string) do
    normalized_string =
      string
      |> String.replace(~r/[-.() ]/, "")
      |> String.replace(~r/^\+?0*/, "")

    with true <- Regex.match?(~r/^\d+$/, normalized_string),
         {:ok, ex_phone_number} <- ExPhoneNumber.parse("+" <> normalized_string, nil),
         true <- ExPhoneNumber.is_valid_number?(ex_phone_number),
         "+" <> e164_string <- ExPhoneNumber.format(ex_phone_number, :e164),
         {e164_integer, ""} <- Integer.parse(e164_string) do
      {:ok, %__MODULE__{e164: e164_integer}}
    else
      _ -> :error
    end
  end

  def cast(nil), do: {:ok, nil}
  def cast(_), do: :error

  def load(e164_string) when is_binary(e164_string) do
    case Integer.parse(e164_string) do
      {e164_integer, ""} ->
        {:ok, %__MODULE__{e164: e164_integer}}

      _ ->
        :error
    end
  end

  def dump(%__MODULE__{e164: e164}) when is_integer(e164), do: {:ok, Integer.to_string(e164)}
  def dump(_), do: :error

  def format(nil), do: nil

  def format(%__MODULE__{e164: e164}, format \\ :international) do
    with e164_integer when is_integer(e164_integer) <- e164,
         {:ok, ex_phone_number} <- ExPhoneNumber.parse("+" <> Integer.to_string(e164_integer), nil) do
      ExPhoneNumber.format(ex_phone_number, format)
    else
      _ -> raise(ArgumentError, "Invalid phone number: #{inspect(e164)}")
    end
  end

  def embed_as(_format) do
    :self
  end

  def equal?(term1, term2) do
    cast(term1) == cast(term2)
  end
end
