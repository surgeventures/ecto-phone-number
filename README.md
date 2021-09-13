# Ecto Phone Number

[![Build Status](https://img.shields.io/circleci/project/github/surgeventures/ecto-phone-number/master.svg)](https://circleci.com/gh/surgeventures/surgeventures/ecto-phone-number/tree/master)
[![Module Version](https://img.shields.io/hexpm/v/ecto_phone_number.svg)](https://hex.pm/packages/ecto_phone_number)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/ecto_phone_number/)
[![Total Download](https://img.shields.io/hexpm/dt/ecto_phone_number.svg)](https://hex.pm/packages/ecto_phone_number)
[![License](https://img.shields.io/hexpm/l/ecto_phone_number.svg)](https://github.com/surgeventures/ecto-phone-number/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/surgeventures/ecto-phone-number.svg)](https://github.com/surgeventures/ecto-phone-number/commits/master)


***Phone number type with validation and formatting for Ecto***

Features:

- Express phone numbers in the code with explicit structure
- Validate and format phone numbers using Google's globally acclaimed `libphonenumber`
- Use the most up-to-date phone definition available for Elixir

## Getting Started

Add `:ecto_phone_number` as a dependency to your project in `mix.exs`:

```elixir
defp deps do
  [
    {:ecto_phone_number, "~> 0.4.1"}
  ]
end
```

Then run `mix deps.get` to fetch it.

## Documentation

Visit documentation on [HexDocs](https://hexdocs.pm/ecto_phone_number) for a complete API reference.


## Copyright and License

Copyright (c) 2017 Surge Ventures

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the [LICENSE.md](./LICENSE.md) file for more details.
