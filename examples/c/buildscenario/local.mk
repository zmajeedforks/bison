## Copyright (C) 2019-2020 Free Software Foundation, Inc.
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

buildscenariodir = $(docdir)/%D%

check_PROGRAMS += %D%/buildscenario

dist_buildscenario_DATA = %D%/parser.y %D%/parser.h %D%/main.c %D%/Makefile %D%/README.md
nodist_%C%_buildscenario_SOURCES = %D%/parse.y %D%/main.c %D%/parse.h
nodist_%C%_buildscenario_OBJECTS = %D%/y.tab.o %D%/main.o

TESTS += %D%/buildscenario.test
EXTRA_DIST += %D%/buildscenario.test

CLEANDIRS += %D%/*.dSYM
CLEANFILES += $(%C%_buildscenario_OBJECTS)

%C%_buildscenario_CPPFLAGS =
%C%_buildscenario_CFLAGS = $(TEST_CFLAGS)

if COMPILER_IS_GCC
  %C%_buildscenario_CFLAGS += \
    -W -Wall -ansi -pedantic \
    -Werror=implicit-function-declaration \
    -Werror=missing-prototypes \
    -Werror=strict-prototypes
endif

%D%/y.tab.c: %D%/parser.y
	$(BISON) --yacc -Wno-yacc -Wno-deprecated -v -d -o$@ $<

%D%/main.o: %D%/parser.h

%D%/y.tab.o: %D%/parser.h %D%/y.tab.h
