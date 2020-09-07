/* Parser for buildscenario.   -*- C -*-

   Copyright (C) 2020 Free Software Foundation, Inc.

   This file is part of Bison, the GNU Compiler Compiler.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

%{

/*
 * These headers must be in that order because "parser.h" needs YYSTYPE in
 * order to define the parser structure.  But parser.h also defines the types
 * that are required for Bison's yyparse declaration in y.tab.h to work.
 * The solution is the hack in the Makefile to remove the yyparse declaration.
 */
#include "y.tab.h"
#include "parser.h"

/*
 * Byacc doesn't need the following at all. We need to add it for Bison
 * because we stripped the yyparse declaration from y.tab.h in the Makefile.
 */
#if YYBISON
int yyparse(scanner_t *, parser_t *);
#endif

void parser_func(scanner_t *s, parser_t *p)
{
  (void) s;
  (void) p;
}

%}

%pure-parser
%parse-param{scanner_t *scnr}
%parse-param{parser_t *parser}
%lex-param{yyscan_t scnr}

%union {
  int val;
}

%token <val> SPACE
%type <val> top

%%

top  : SPACE  { $$ = $1; parser->ast = 0; }
     ;

%%

int yylex(YYSTYPE *yyparam, yyscan_t scanner)
{
  yyparam->val = 42;
  (void) scanner;
  return SPACE;
}

parser_t *parser_create(void)
{
  return 0;
}

int parse(parser_t *p)
{
  if (0)
    yyparse(p->scanner, p);
  return 0;
}

void yyerror(scanner_t *scanner, parser_t *parser, const char *s)
{
  (void) scanner;
  (void) parser;
  (void) s;
}
