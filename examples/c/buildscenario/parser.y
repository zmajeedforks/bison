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

%code requires {

  typedef struct yyguts_t scanner_t;
  typedef struct parser parser_t;
  typedef void *yyscan_t;

}

%code provides {
  struct token {
    YYSTYPE yy_lval;
  };

  struct parser {
    scanner_t *scanner;
    struct token tok;
    void *ast;
  };

  int yylex(YYSTYPE *yylval_param, yyscan_t yyscanner);

  void yyerror(scanner_t *scanner, parser_t *, const char *s);
  void parser_func(scanner_t *s, parser_t *p);
  parser_t *parser_create(void);
  int parse(parser_t *);
}

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

void parser_func(scanner_t *s, parser_t *p)
{
  (void) s;
  (void) p;
}

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
