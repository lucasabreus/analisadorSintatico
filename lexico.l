%{
#include <stdio.h>
#include <stdlib.h>
#include "sintatic.h"
int ligado = 0,caso = 0;

%}

se "if"
senao "else"
retorno "return"
enquanto "while"
vazio "void"
operador se|senao|retorno|enquanto
inteiro "int"
simboloduplo "<="|">="|"=="|"!="
simbolounico [\+|\-|\*|\/|\<|\>|\,|\;|\(|\)|\[|\]|\{|\}|\=]
abrecomentario "/*"
fechacomentario "*/"
simbolo {simboloduplo}|{simbolounico}
letra [a-z]|[A-Z]
digito [0-9]
letras {letra}{letra}*
num {digito}{digito}*
branco [ \n\t\r]+

%%
{abrecomentario} 	{ ligado = 1; }
{fechacomentario} 	{ ligado = 0; }
{se}				{ if ( ligado == 0 ) return(SE); }
{senao}				{ if ( ligado == 0 ) return(SENAO); }	
{enquanto}				{ if ( ligado == 0 ) return(ENQUANTO); }	
{retorno}				{ if ( ligado == 0 ) return(RETORNO); }	
{vazio}					{ if ( ligado == 0 ) return(VAZIO); }	
{inteiro}				{ if ( ligado == 0 ) return(INTEIRO); }	
{simbolounico} 			{  if ( ligado == 0 ){
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
{simboloduplo}      {   if ( ligado == 0 ){ 
							if ( yytext[0] == '<' && yytext[1] == '=' ) return(MENORIGUAL); 
							if ( yytext[0] == '>' && yytext[1] == '=' ) return(MAIORIGUAL); 
							if ( yytext[0] == '=' && yytext[1] == '=' ) return(IGUALIGUAL); 
							if ( yytext[0] == '!' && yytext[1] == '=' ) return(DIFERENTE); 
						}
					 }
{letras} 			{ if ( ligado == 0 ) { yylval.str_t = yytext; return(ID); } }
{num} 				{ if ( ligado == 0 ) return(NUM); }
{branco} 			{}
. 					{ if ( ligado == 0 ) printf("Entrada inválida: %s\n",yytext); }
%%
