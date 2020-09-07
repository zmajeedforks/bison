# buildscenario - a realistic Bison build scenario with historic warts.

This directory contains buildscenario, a program which doesn't do
anything, but is required to build successfully.

The structure of this program mimics one that is found in a
real-world program, the TXR language.

It uses %pure-parser and can build not only with Bison, but also with
Berkeley Yacc, which implements %pure-parse in a manner that remains
compatible with Bison 2.

The parser.h header defines the scanner and parser type definitions.

If the y.tab.h header is included before parser.h, then parser.h
provides the complete declaration of the parser structure.
Otherwise it provides an incomplete declaration only.

C files implementing the parser objects therefore include y.tab.h before
parser.h. A representation of such files is omitted from this condensed
sample; they are not exemplified.

Other C files in the application that need to use the parser only
include parser.h. They receive only an opaque interface. Such modules of the
program are exemplified by main.c in this example.

The parser structure's body references the YYSTYPE union, which is why it
requires requires y.tab.h. Since y.tab.h defines well-known symbols (the
token macros) it is possible to easily and portably detect whether it has been
included.

Because the parser is pure, the yyparse function takes a pointer to the parser
structure as one of its parameters.  At some point, bison 3.x introduced a
prototype declaration of yyparse into y.tab.h. This creates a circular
dependency: parser.h needs y.tab.h for YYSTYPE, but y.tab.h needs the parser
type to be declared for the prototype of yyparse. This is why the Makefile
for buildscenario contains a step to remove the yyparse declaration from
y.tab.h. This is not necessary with bison 2.x or wit Berkeley Yacc.
If that filtering step is omitted, buildscenario will not build.

In this program organization, only the parser.y file contains a call to
yyparse; this illustrates that the declaration of yyparse is not required at
all outside of that file. A wrapper function calls yyparse, from a point in
the file where the full definition of yyparse is in scope, providing a
declaration.

The %purse-parser declaration is deprecated in Bison. Moreover, if it
is used in --yacc mode, there is a warning from Bison about a non-POSIX
extension being used. The -Wno-yacc and -Wno-deprecated options are
used to suppress these diagnostics.

<!---
Local Variables:
fill-column: 76
ispell-dictionary: "american"
End:

Copyright (C) 2019-2020 Free Software Foundation, Inc.

This file is part of Bison, the GNU Compiler Compiler.

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3 or
any later version published by the Free Software Foundation; with no
Invariant Sections, with no Front-Cover Texts, and with no Back-Cover
Texts.  A copy of the license is included in the "GNU Free
Documentation License" file as part of this distribution.

--->
