/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     SEX = 258,
     SENAOX = 259,
     ID = 260,
     NUM = 261,
     SIMBOLO = 262,
     MAIS = 263,
     MENOS = 264,
     VEZES = 265,
     DIVISAO = 266,
     MENOR = 267,
     MAIOR = 268,
     VIRGULA = 269,
     ABREPARENTESIS = 270,
     FECHAPARENTESIS = 271,
     ABRECOLCHETES = 272,
     FECHACOLCHETES = 273,
     ABRECHAVES = 274,
     FECHACHAVES = 275,
     IGUAL = 276,
     PV = 277,
     SE = 278,
     SENAO = 279,
     RETORNO = 280,
     ENQUANTO = 281,
     VAZIO = 282,
     INTEIRO = 283,
     MAIORIGUAL = 284,
     MENORIGUAL = 285,
     IGUALIGUAL = 286,
     DIFERENTE = 287
   };
#endif
/* Tokens.  */
#define SEX 258
#define SENAOX 259
#define ID 260
#define NUM 261
#define SIMBOLO 262
#define MAIS 263
#define MENOS 264
#define VEZES 265
#define DIVISAO 266
#define MENOR 267
#define MAIOR 268
#define VIRGULA 269
#define ABREPARENTESIS 270
#define FECHAPARENTESIS 271
#define ABRECOLCHETES 272
#define FECHACOLCHETES 273
#define ABRECHAVES 274
#define FECHACHAVES 275
#define IGUAL 276
#define PV 277
#define SE 278
#define SENAO 279
#define RETORNO 280
#define ENQUANTO 281
#define VAZIO 282
#define INTEIRO 283
#define MAIORIGUAL 284
#define MENORIGUAL 285
#define IGUALIGUAL 286
#define DIFERENTE 287




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 30 "sintatic.y"
{
    char* str_t;
    void* no_t;
}
/* Line 1529 of yacc.c.  */
#line 118 "sintatic.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

