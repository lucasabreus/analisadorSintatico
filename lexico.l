%{
#include <stdio.h>
#include <stdlib.h>
#include "sintatic.h"
int ligado = 0,caso = 0;

%}

operador "if"|"else"|"return"|"while"
tipo "int"|"void"
simboloduplo "<="|">="|"=="|"!="
simbolounico [\+|\-|\*|\/|\<|\>|\,|\;|\(|\)|\[|\]|\{|\}|\=]
abrecomentario "/*"
fechacomentario "*/"
simbolo {simboloduplo}|{simbolounico}
letra [a-z]|[A-Z]
digito [0-9]
letras {letra}{letra}*
num {digito}{digito}*
branco [ \t\n]

%%
{abrecomentario} 	{ ligado = 1; }
{fechacomentario} 	{ ligado = 0; }
{tipo} 				{ yylval.str_t = yytext; if ( ligado == 0 ) return(TYPE); }
{simbolo} 			{  if ( ligado == 0 ){
							yylval.str_t = yytext;
							if ( yytext[0] == '+' ) return(MAIS);
							if ( yytext[0] == '-' ) return(MENOS);
							if ( yytext[0] == '*' ) return(VEZES);
							if ( yytext[0] == '/' ) return(DIVISAO);
							if ( yytext[0] == '<' ) return(MENOR);
							if ( yytext[0] == '>' ) return(MAIOR);
							if ( yytext[0] == ',' ) return(VIRGULA);
							if ( yytext[0] == '(' ) return(ABREPARENTESIS);
							if ( yytext[0] == ')' ) return(FECHAPARENTESIS);
							if ( yytext[0] == '[' ) return(ABRECOLCHETES);
							if ( yytext[0] == ']' ) return(FECHACOLCHETES);
							if ( yytext[0] == '{' ) return(ABRECHAVES);
							if ( yytext[0] == '}' ) return(FECHACHAVES);
							if ( yytext[0] == '=' ) return(IGUAL);
							if ( yytext[0] == ';' ) return(PV);
						}
					}
{letras} 			{ if ( ligado == 0 ) { yylval.str_t = yytext; return(ID); } }
{num} 				{ if ( ligado == 0 ) return(NUM); }
{branco} 			{}
. 					{ printf("Entrada inválida: %s\n",yytext); }
%%
