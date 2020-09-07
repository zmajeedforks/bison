# This Makefile is designed to be simple and readable.  It does not
# aim at portability.  It requires GNU Make.
BASE = buildscenario

CFLAGS += -W -Wall -ansi -pedantic \
          -Werror=implicit-function-declaration \
          -Werror=missing-prototypes \
          -Werror=strict-prototypes
BISON = bison --yacc
ifneq (BISON,byacc)
BISONFLAGS += -Wno-deprecated -Wno-yacc
endif

CLEANFILES = $(BASE) main.o y.tab.o y.tab.h y.tab.c y.output

$(BASE): main.o y.tab.o
	$(CC) -o $@ $^

run: $(BASE)
	@echo "This program doesn't do anything."
	./$<

y.tab.c: parser.y
	$(BISON) $(BISONFLAGS) -v -d $<
	# workaround for Bison 3.x: yyparse declared in y.tab.h
ifneq (BISON,byacc)
	sed -e /yyparse/d < y.tab.h > y.tab.h.tmp
	mv y.tab.h.tmp y.tab.h
endif

main.o: parser.h

y.tab.o: parser.h y.tab.h

clean:
	-rm -f $(CLEANFILES)
