defmodule EctoPhoneNumberTest do
  use ExUnit.Case
  alias EctoPhoneNumber

  @phone_number_string_formatted "+48 600 700 800"
  @phone_number_string_formatted_alt "+048 600-700-800"
  @phone_number_string_e164 "48600700800"
  @phone_number_e164 48_600_700_800
  @phone_number %EctoPhoneNumber{e164: @phone_number_e164}

  @phone_number_string_with_invalid_delimiter "+48 600/700-800"
  @phone_number_string_with_invalid_digits "+48 100-000-000"
  @phone_number_with_no_data %EctoPhoneNumber{e164: nil}
  @phone_number_with_invalid_type %EctoPhoneNumber{e164: @phone_number_string_e164}
  @phone_number_with_invalid_digits %EctoPhoneNumber{e164: 48_100_000_000}

  describe "Inspect.inspect/2" do
    test "inspects valid phone numbers" do
      assert inspect(@phone_number) == "#EctoPhoneNumber<#{@phone_number_e164}>"
    end

    test "inspects invalid phone numbers" do
      assert inspect(@phone_number_with_invalid_type) ==
               "#EctoPhoneNumber<#{@phone_number_string_e164}>"

      assert inspect(@phone_number_with_invalid_digits) == "#EctoPhoneNumber<48100000000>"
    end
  end

  describe "String.Chars.to_string/1" do
    test "interpolates valid phone number in strings" do
      assert "Phone: #{@phone_number}" == "Phone: #{@phone_number_string_formatted}"
    end

    test "interpolates invalid phone numbers in valid structs in strings" do
      assert "Phone: #{@phone_number_with_invalid_digits}" == "Phone: +48 100000000"
    end

    test "interpolates invalid phone number struct in strings" do
      assert "Phone: #{@phone_number_with_no_data}" == "Phone: "
      assert "Phone: #{@phone_number_with_invalid_type}" == "Phone: 48600700800"
    end
  end

  describe "type/0" do
    test "returns proper type" do
      assert EctoPhoneNumber.type() == :string
    end
  end

  describe "cast/1" do
    test "casts itself" do
      assert EctoPhoneNumber.cast(@phone_number) == {:ok, @phone_number}
    end

    test "casts valid strings" do
      assert EctoPhoneNumber.cast(@phone_number_string_formatted) == {:ok, @phone_number}
      assert EctoPhoneNumber.cast(@phone_number_string_formatted_alt) == {:ok, @phone_number}
      assert EctoPhoneNumber.cast(@phone_number_string_e164) == {:ok, @phone_number}
    end

    test "casts valid integers" do
      assert EctoPhoneNumber.cast(@phone_number_e164) == {:ok, @phone_number}
    end

    test "casts invalid strings" do
      assert EctoPhoneNumber.cast(@phone_number_string_with_invalid_delimiter) == :error
      assert EctoPhoneNumber.cast(@phone_number_string_with_invalid_digits) == :error
    end
  end

  describe "load/1" do
    test "loads valid string" do
      assert EctoPhoneNumber.load(@phone_number_string_e164) == {:ok, @phone_number}
    end

    test "loads invalid string" do
      assert EctoPhoneNumber.load(@phone_number_string_formatted) == :error
    end
  end

  describe "dump/1" do
    test "dumps valid phone numbers" do
      assert EctoPhoneNumber.dump(@phone_number) == {:ok, @phone_number_string_e164}
    end

    test "dumps invalid phone numbers in valid struct" do
      assert EctoPhoneNumber.dump(@phone_number) == {:ok, @phone_number_string_e164}
      assert EctoPhoneNumber.dump(@phone_number_with_invalid_digits) == {:ok, "48100000000"}
    end

    test "dumps invalid phone number structs" do
      assert EctoPhoneNumber.dump(@phone_number_with_no_data) == :error
      assert EctoPhoneNumber.dump(@phone_number_with_invalid_type) == :error
    end
  end

  describe "format/1" do
    test "formats valid phone numbers" do
      assert EctoPhoneNumber.format(@phone_number) == @phone_number_string_formatted
    end

    test "formats invalid numbers in valid struct" do
      assert EctoPhoneNumber.format(@phone_number_with_invalid_digits) == "+48 100000000"
    end

    test "raises on invalid phone number structs" do
      assert_raise(ArgumentError, fn ->
        EctoPhoneNumber.format(@phone_number_with_no_data)
      end)

      assert_raise(ArgumentError, fn ->
        EctoPhoneNumber.format(@phone_number_with_invalid_type)
      end)
    end
  end

  describe "equal?/1" do
    test "equals itself" do
      assert EctoPhoneNumber.equal?(@phone_number, @phone_number)
    end

    test "does not equals other" do
      refute EctoPhoneNumber.equal?(@phone_number, "48600700811")
    end

    test "equals e164 integer" do
      assert EctoPhoneNumber.equal?(@phone_number, @phone_number_e164)
    end

    test "equals e164 string" do
      assert EctoPhoneNumber.equal?(@phone_number, to_string(@phone_number_e164))
    end

    test "does not equals nil" do
      refute EctoPhoneNumber.equal?(@phone_number, nil)
    end
  end
end
