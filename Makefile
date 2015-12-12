# Master Makefile

all:
	$(MAKE) -f compile.mk
	$(MAKE) -f cook.mk
	$(MAKE) -f report.mk
