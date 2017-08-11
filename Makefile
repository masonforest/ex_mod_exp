MIX = mix
CFLAGS = -g -O3 -ansi -pedantic -Wall -Wextra -Wno-unused-parameter

ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
LDFLAGS += -lcrypto
CFLAGS += -I$(ERLANG_PATH)


CFLAGS += -I$(HOEDOWN_PATH)/src

ifneq ($(OS),Windows_NT)
	CFLAGS += -fPIC

	ifeq ($(shell uname),Darwin)
		LDFLAGS += -dynamiclib -undefined dynamic_lookup
	endif
endif

.PHONY: all open_ssl clean

all: open_ssl

open_ssl:
	$(MIX) compile

priv/open_ssl.so: src/open_ssl.c
	$(MAKE)
	$(CC) $(CFLAGS) -shared $(LDFLAGS) -o $@ src/open_ssl.c
clean:
	$(MIX) clean
	$(MAKE) clean
	$(RM) priv/open_ssl.so
