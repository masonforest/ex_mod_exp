defmodule OpenSSL do
  @moduledoc """
  OpenSSL to HTML conversion.
  """

  @on_load { :init, 0 }

  app = Mix.Project.config[:app]

  def init do
    path = :filename.join(:code.priv_dir(unquote(app)), 'open_ssl')
    :ok = :erlang.load_nif(path, 0)
  end

  @doc ~S"""
  Converts a OpenSSL document to HTML:

      iex> OpenSSL.mod_exp(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff, 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe, 0x1000000000000000000000000000000000000000000000000000000000000000)
      1
      # iex> OpenSSL.bn_mod_exp(:binary.encode_unsigned(11231),:binary.encode_unsigned(21231),:binary.encode_unsigned(31231))
      #21493

  """
  def mod_exp(a, b, c) do
    bn_mod_exp(
      :binary.encode_unsigned(a),
      :binary.encode_unsigned(b),
      :binary.encode_unsigned(c)
    )
  end

  def bn_mod_exp(a, b, c)

  def bn_mod_exp(_, _, _) do
    exit(:nif_library_not_loaded)
  end
end
