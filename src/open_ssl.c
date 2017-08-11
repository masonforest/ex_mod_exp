#include <string.h>
#include <stdint.h>

#include <openssl/bn.h>
#include "erl_nif.h"

#define OUTPUT_UNIT 128
#define MAXBUFLEN   1024

typedef struct {
  ERL_NIF_TERM atom_true;
  ERL_NIF_TERM atom_tables;
  ERL_NIF_TERM atom_autolink;
  ERL_NIF_TERM atom_fenced_code;
} open_ssl_priv;

static ERL_NIF_TERM
bn_mod_exp(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
  ErlNifBinary a, b, c;
  BN_CTX *bctx;
  BIGNUM *bn_a;
  BIGNUM *bn_b;
  BIGNUM *bn_c;
  int r;
  BIGNUM *res;
  if (!enif_inspect_binary(env, argv[0], &a))
    return enif_make_badarg(env);
  if (!enif_inspect_binary(env, argv[1], &b))
    return enif_make_badarg(env);
  if (!enif_inspect_binary(env, argv[2], &c))
    return enif_make_badarg(env);

  bctx = BN_CTX_new();
  bn_a = BN_new();
  bn_b = BN_new();
  bn_c = BN_new();
  res = BN_new();
  BN_bin2bn(a.data, a.size, bn_a);
  BN_bin2bn(b.data, b.size, bn_b);
  BN_bin2bn(c.data, c.size, bn_c);
  BN_mod_exp(res, bn_a, bn_b, bn_c, bctx);
  BN_CTX_free(bctx);
  BN_free(bn_a);
  BN_free(bn_b);
  BN_free(bn_c);
  r = BN_get_word(res);
  BN_free(res);

  return enif_make_int(env, r);
}

static ErlNifFunc funcs[] = {
  { "bn_mod_exp", 3, bn_mod_exp, 0 }
};

ERL_NIF_INIT(Elixir.OpenSSL, funcs, NULL, NULL, NULL, NULL)
