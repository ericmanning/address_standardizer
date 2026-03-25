.DEFAULT_GOAL := all

.PHONY: all check install installcheck uninstall noop clean distclean

all install installcheck uninstall noop clean distclean:
	+@$(MAKE) -f Makefile $@

check:
	+@PG_CONFIG="$(PG_CONFIG)" MAKE="$(MAKE)" sh tools/run-check.sh
