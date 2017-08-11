# Ex Mod Exp

[Modular exponentiation](https://en.wikipedia.org/wiki/Modular_exponentiation)
for elixir

## Usage

```iex
iex> OpenSSL.mod_exp(2, 16, 10)
6
```

## Installation

mod_exp depends on OpenSSL.

If you're on a Mac:

    brew install openssl
    export LDPATH=/usr/local/Cellar/openssl/lib
    export INCLUDE_PATH=/usr/local/Cellar/openssl/include
