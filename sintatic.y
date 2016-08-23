
%{

#include <stdio.h>
#include <ctype.h>
#include "lex.yy.c"
#include <string.h>

int yyerror(char * s) {
	return 0;
} 

typedef struct no{
	char* nome;
	struct no* filhos;
	int qtd;	
}no;

void imprime ( no a, int espacos ){
	for(int i=0;i<espacos;i++) printf(" ");
	printf("%s\n",a.nome);
	for(int i=0;i<a.qtd;i++){
		imprime(a.filhos[i],espacos+4);
	}
}

%}

%union 
{
    char* str_t;
    void* no_t;
}

%token <str_t> ID
%token <str_t> NUM
%token <str_t> TYPE
%token <str_t> SIMBOLO
%token <str_t> MAIS
%token <str_t> MENOS
%token <str_t> VEZES
%token <str_t> DIVISAO
%token <str_t> MENOR
%token <str_t> MAIOR
%token <str_t> VIRGULA
%token <str_t> ABREPARENTESIS
%token <str_t> FECHAPARENTESIS
%token <str_t> ABRECOLCHETES
%token <str_t> FECHACOLCHETES
%token <str_t> ABRECHAVES
%token <str_t> FECHACHAVES
%token <str_t> IGUAL
%token <str_t> PV

%type <no_t> programa;
%type <no_t> listadeclaracoes;
%type <no_t> declaracao;
%type <no_t> declaracaovariaveis;
%type <no_t> declaracaofuncoes;
%type <no_t> parametros;
%type <no_t> listaparametros;
%type <no_t> param;
%type <no_t> declaracoeslocais;
%type <no_t> listacomandos;
%type <no_t> comando;
%type <no_t> declaracaoexpressao;
%type <no_t> declaracaocomposta;
%type <no_t> declaracaoselecao;
%type <no_t> declaracaoiteracao;
%type <no_t> declaracaoretorno;
%type <no_t> expressao;
%type <no_t> variavel;
%type <no_t> expressaosimples;
%type <no_t> oprelacional;
%type <no_t> somaexpressao;
%type <no_t> soma;
%type <no_t> termo;
%type <no_t> fator;
%type <no_t> ativacao;
%type <no_t> mult;
%type <no_t> argumentos;
%type <no_t> listaargumentos;

%%
programa : listadeclaracoes { 	
								no * aux = (no*) malloc(sizeof(no));
								aux->nome = strdup("programa");
								aux->filhos = (no*)malloc(sizeof(no) * 100);
								aux->qtd = 0;
								aux->filhos[aux->qtd++] = *((no*)$1);
								imprime(*aux,0);
							}

listadeclaracoes : listadeclaracoes declaracao  {
								no * aux = (no*) malloc(sizeof(no));
								aux->nome = strdup("listadeclaracoes");
								aux->filhos = (no*)malloc(sizeof(no) * 100);
								aux->qtd = 0;
								aux->filhos[aux->qtd++] = *((no*)$1);
								aux->filhos[aux->qtd++] = *((no*)$2);
								$$ = aux;
							} 
				   | declaracao { 
					   				no * aux = (no*) malloc(sizeof(no));
									aux->nome = strdup("listadeclaracoes");
									aux->filhos = (no*)malloc(sizeof(no) * 100);
									aux->qtd = 0;
									aux->filhos[aux->qtd++] = *((no*)$1);
									$$ = aux;
				   				}

declaracao : declaracaovariaveis {  
									no * aux = (no*) malloc(sizeof(no));
									aux->nome = strdup("declaracao");
									aux->filhos = (no*)malloc(sizeof(no) * 100);
									aux->qtd = 0;
									aux->filhos[aux->qtd++] = *((no*)$1);
									$$ = aux;
								 } 
			| declaracaofuncoes { 
									no * aux = (no*) malloc(sizeof(no));
									aux->nome = strdup("declaracao");
									aux->filhos = (no*)malloc(sizeof(no) * 100);
									aux->qtd = 0;
									aux->filhos[aux->qtd++] = *((no*)$1);
									$$ = aux;
								}

declaracaovariaveis : TYPE ID PV {
									no * aux = (no*) malloc(sizeof(no));
									aux->nome = strdup("declaracaoVariaveis");
									aux->filhos = (no*)malloc(sizeof(no) * 100);

									no * f1 = (no*) malloc(sizeof(no));
									f1->nome = strdup($1);
									f1->qtd = 0;
									no * f2 = (no*) malloc(sizeof(no));
									f2->nome = strdup($2);
									f2->qtd = 0;
									no * f3 = (no*) malloc(sizeof(no));
									f3->nome = strdup($3);
									f3->qtd = 0;

									aux->filhos[0] = *f1;
									aux->filhos[1] = *f2;
									aux->filhos[2] = *f3;
									aux->qtd = 3;
									$$ = aux;
								 } 
				    | TYPE ID ABRECOLCHETES NUM FECHACOLCHETES PV { 
				    				no * aux = (no*) malloc(sizeof(no));
				    				no * tipo = (no*) malloc(sizeof(no));
									aux->nome = strdup("listadeclaracoes");
									aux->filhos = (no*)malloc(sizeof(no) * 100);

									no * f1 = (no*) malloc(sizeof(no));
									f1->nome = strdup("TIPO");
									f1->qtd = 0;
									no * f2 = (no*) malloc(sizeof(no));
									f2->nome = strdup("ID");
									f2->qtd = 0;
									no * f3 = (no*) malloc(sizeof(no));
									f3->nome = strdup("[");
									f3->qtd = 0;
									no * f4 = (no*) malloc(sizeof(no));
									f4->nome = strdup("NUM");
									f4->qtd = 0;
									no * f5 = (no*) malloc(sizeof(no));
									f5->nome = strdup("]");
									f5->qtd = 0;
									no * f6 = (no*) malloc(sizeof(no));
									f6->nome = strdup(";");
									f6->qtd = 0;

									aux->filhos[0] = *f1;
									aux->filhos[1] = *f2;
									aux->filhos[2] = *f3;
									aux->filhos[3] = *f4;
									aux->filhos[4] = *f5;
									aux->filhos[5] = *f6;
									aux->qtd = 6;
									$$ = aux;
				    			}

declaracaofuncoes : TYPE ID ABREPARENTESIS parametros FECHAPARENTESIS declaracaocomposta{ 
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("declaracaofuncoes");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	
	no * f1 = (no*) malloc(sizeof(no));
	f1->nome = strdup("TIPO");
	f1->qtd = 0;
	no * f2 = (no*) malloc(sizeof(no));
	f2->nome = strdup("ID");
	f2->qtd = 0;
	no * f3 = (no*) malloc(sizeof(no));
	f3->nome = strdup("(");
	f3->qtd = 0;
	no * f5 = (no*) malloc(sizeof(no));
	f5->nome = strdup(")");
	f5->qtd = 0;

	aux->filhos[0] = *f1;
	aux->filhos[1] = *f2;
	aux->filhos[2] = *f3;
	aux->filhos[3] = *((no*)$4);
	aux->filhos[4] = *f5;
	aux->filhos[5] = *((no*)$6);

	aux->qtd = 6;
	$$ = aux;
}

parametros : listaparametros {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("parametros");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	aux->filhos[aux->qtd++] = *((no*)$1);
	$$ = aux;
} 
| 'void' {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("parametros");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	no * f1 = (no*) malloc(sizeof(no));
	f1->nome = strdup("void");
	f1->qtd = 0;
	aux->filhos[aux->qtd++] = *f1;
	$$ = aux;
}

listaparametros : listaparametros VIRGULA param {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("listaparametros");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	aux->filhos[aux->qtd++] = *((no*)$1);
	no * f2 = (no*) malloc(sizeof(no));
	f2->nome = strdup(",");
	f2->qtd = 0;
	aux->filhos[aux->qtd++] = *f2;
	aux->filhos[aux->qtd++] = *((no*)$3);
	$$ = aux;
} | param {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("listaparametros");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	aux->filhos[aux->qtd++] = *((no*)$1);
	$$ = aux;
}

param : TYPE ID { 
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("param");
	aux->filhos = (no*)malloc(sizeof(no) * 100);

	no * f1 = (no*) malloc(sizeof(no));
	f1->nome = strdup("TIPO");
	f1->qtd = 0;
	no * f2 = (no*) malloc(sizeof(no));
	f2->nome = strdup("ID");
	f2->qtd = 0;

	aux->filhos[0] = *f1;
	aux->filhos[1] = *f2;
	aux->qtd = 2;
	$$ = aux;
}
| TYPE ID ABRECOLCHETES NUM FECHACOLCHETES {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("param");
	aux->filhos = (no*)malloc(sizeof(no) * 100);

	no * f1 = (no*) malloc(sizeof(no));
	f1->nome = strdup("TIPO");
	f1->qtd = 0;
	no * f2 = (no*) malloc(sizeof(no));
	f2->nome = strdup("ID");
	f2->qtd = 0;
	no * f3 = (no*) malloc(sizeof(no));
	f3->nome = strdup("[");
	f3->qtd = 0;
	no * f4 = (no*) malloc(sizeof(no));
	f4->nome = strdup("NUM");
	f4->qtd = 0;
	no * f5 = (no*) malloc(sizeof(no));
	f5->nome = strdup("]");
	f5->qtd = 0;

	aux->filhos[0] = *f1;
	aux->filhos[1] = *f2;
	aux->filhos[2] = *f3;
	aux->filhos[3] = *f4;
	aux->filhos[4] = *f5;
	aux->qtd = 5;
	$$ = aux;
}

declaracaocomposta : ABRECHAVES declaracoeslocais listacomandos FECHACHAVES {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("declaracaocomposta");
	aux->filhos = (no*)malloc(sizeof(no) * 100);

	no * f1 = (no*) malloc(sizeof(no));
	f1->nome = strdup("{");
	f1->qtd = 0;
	no * f4 = (no*) malloc(sizeof(no));
	f4->nome = strdup("}");
	f4->qtd = 0;

	aux->filhos[0] = *f1;
	aux->filhos[1] = *((no*)$2);
	aux->filhos[2] = *((no*)$3);
	aux->filhos[3] = *f4;
	aux->qtd = 4;
	$$ = aux;
}

declaracoeslocais : declaracoeslocais declaracaovariaveis { 
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("declaracoeslocais");
	aux->filhos = (no*)malloc(sizeof(no) * 100);

	aux->filhos[aux->qtd++] = *((no*)$1);
	aux->filhos[aux->qtd++] = *((no*)$2);
	$$ = aux;
} | /*epsilon*/ {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("declaracoeslocais");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	$$ = aux;
}

listacomandos : listacomandos comando { 
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("listacomandos");
	aux->filhos = (no*)malloc(sizeof(no) * 100);

	aux->filhos[aux->qtd++] = *((no*)$1);
	aux->filhos[aux->qtd++] = *((no*)$2);
	$$ = aux;
} | /*epsilon*/ {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("listacomandos");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	$$ = aux;
}

comando : declaracaoexpressao {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("comando");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->filhos[aux->qtd++] = *((no*)$1);
	$$ = aux;
} | declaracaocomposta {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("comando");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->filhos[aux->qtd++] = *((no*)$1);
	$$ = aux;
} | declaracaoselecao {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("comando");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->filhos[aux->qtd++] = *((no*)$1);
	$$ = aux;
} | declaracaoiteracao {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("comando");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->filhos[aux->qtd++] = *((no*)$1);
	$$ = aux;
} | declaracaoretorno {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("comando");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->filhos[aux->qtd++] = *((no*)$1);
	$$ = aux;
}

declaracaoiteracao : 'while' ABREPARENTESIS expressao FECHAPARENTESIS comando {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("declaracaocomposta");
	aux->filhos = (no*)malloc(sizeof(no) * 100);

	no * f1 = (no*) malloc(sizeof(no));
	f1->nome = strdup("while");
	f1->qtd = 0;
	no * f2 = (no*) malloc(sizeof(no));
	f2->nome = strdup("(");
	f2->qtd = 0;
	no * f4 = (no*) malloc(sizeof(no));
	f4->nome = strdup(")");
	f4->qtd = 0;

	aux->filhos[0] = *f1;
	aux->filhos[1] = *f2;
	aux->filhos[2] = *((no*)$3);
	aux->filhos[3] = *f4;
	aux->filhos[4] = *((no*)$5);
	aux->qtd = 5;
	$$ = aux;
}

declaracaoexpressao : expressao PV {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("declaracaoexpressao");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	
	aux->filhos[0] = *((no*)$1);
	no * f1 = (no*) malloc(sizeof(no));
	f1->nome = strdup(";");
	f1->qtd = 0;
	aux->filhos[1] = *f1;
	
	aux->qtd = 2;
	$$ = aux;
} | PV {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("declaracaoexpressao");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
		no * f1 = (no*) malloc(sizeof(no));
		f1->nome = strdup(";");
		f1->qtd = 0;
		aux->filhos[0] = *f1;
	aux->qtd = 1;
	$$ = aux;
}

expressao : variavel IGUAL expressao {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("expressao");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	
	aux->filhos[0] = *((no*)$1);
	no * f1 = (no*) malloc(sizeof(no));
	f1->nome = strdup("=");
	f1->qtd = 0;
	aux->filhos[1] = *f1;
	aux->filhos[2] = *((no*)$3);
	
	aux->qtd = 3;
	$$ = aux;
} | expressaosimples {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("expressao");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	
	aux->filhos[0] = *((no*)$1);
	aux->qtd = 1;
	$$ = aux;
}

variavel : ID {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("variavel");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
		no * f1 = (no*) malloc(sizeof(no));
		f1->nome = strdup(yytext);
		f1->qtd = 0;
		aux->filhos[0] = *f1;
	aux->qtd = 0;
	$$ = aux;
} | ID ABRECOLCHETES expressao FECHACOLCHETES {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("variavel");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
		no * f1 = (no*) malloc(sizeof(no));
		f1->nome = strdup("ID");
		f1->qtd = 0;
		no * f2 = (no*) malloc(sizeof(no));
		f2->nome = strdup("[");
		f2->qtd = 0;
		no * f4 = (no*) malloc(sizeof(no));
		f4->nome = strdup("]");
		f4->qtd = 0;
		aux->filhos[0] = *f1;
		aux->filhos[1] = *f2;
		aux->filhos[2] = *((no*)$3);
		aux->filhos[3] = *f4;
	aux->qtd = 4;
	$$ = aux;
}

expressaosimples : somaexpressao oprelacional somaexpressao {
	
} | somaexpressao {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("expressaosimples");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 1;
	aux->filhos[0] = *((no*)$1);
	$$ = aux;
}

declaracaocomposta : /*epsilon*/ {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("declaracaocomposta");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	$$ = aux;
}

declaracaoretorno : 'return' PV {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("declaracaoretorno");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
		no * f1 = (no*) malloc(sizeof(no));
		f1->nome = "retorno";
		f1->qtd = 0;
		no * f2 = (no*) malloc(sizeof(no));
		f2->nome = ";";
		f2->qtd = 0;
		aux->filhos[0] = *f1;
		aux->filhos[1] = *f2;
	aux->qtd = 2;
	$$ = aux;
} | 'return' expressao PV {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("declaracaoretorno");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
		no * f1 = (no*) malloc(sizeof(no));
		f1->nome = "retorno";
		f1->qtd = 0;
		no * f3 = (no*) malloc(sizeof(no));
		f3->nome = ";";
		f3->qtd = 0;
		aux->filhos[0] = *f1;
		aux->filhos[1] = *((no*)$2);
		aux->filhos[2] = *f3;
	aux->qtd = 3;
	$$ = aux;
}

declaracaoselecao : 'if' ABREPARENTESIS expressao FECHAPARENTESIS comando {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("declaracaoselecao");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	no * f1 = (no*) malloc(sizeof(no));
	f1->nome = strdup("if");
	f1->qtd = 0;
	no * f2 = (no*) malloc(sizeof(no));
	f2->nome = strdup("(");
	f2->qtd = 0;
	no * f3 = (no*) malloc(sizeof(no));
	f3->nome = strdup(")");
	f3->qtd = 0;

	aux->filhos[0] = *f1;
	aux->filhos[1] = *f2;
	aux->filhos[2] = *((no*)$3);
	aux->filhos[3] = *f3;
	aux->filhos[4] = *((no*)$5);
	aux->qtd = 5;
	$$ = aux;
} | 'if' ABREPARENTESIS expressao FECHAPARENTESIS comando 'else' comando {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("declaracaoselecao");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	no * f1 = (no*) malloc(sizeof(no));
	f1->nome = strdup("if");
	f1->qtd = 0;
	no * f2 = (no*) malloc(sizeof(no));
	f2->nome = strdup("(");
	f2->qtd = 0;
	no * f3 = (no*) malloc(sizeof(no));
	f3->nome = strdup(")");
	f3->qtd = 0;
	no * f4 = (no*) malloc(sizeof(no));
	f4->nome = strdup("else");
	f4->qtd = 0;

	aux->filhos[0] = *f1;
	aux->filhos[1] = *f2;
	aux->filhos[2] = *((no*)$3);
	aux->filhos[3] = *f3;
	aux->filhos[4] = *((no*)$5);
	aux->filhos[5] = *f4;
	aux->filhos[5] = *((no*)$7);
	aux->qtd = 7;
	$$ = aux;
}

oprelacional : '<=' { 
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("<=");
	aux->qtd = 0;
	$$ = aux;
} | MENOR {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("<");
	aux->qtd = 0;
	$$ = aux;
} | MAIOR {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup(">");
	aux->qtd = 0;
	$$ = aux;
} | '>=' {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup(">=");
	aux->qtd = 0;
	$$ = aux;
} | '==' {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("==");
	aux->qtd = 0;
	$$ = aux;
} | '!='{
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("!=");
	aux->qtd = 0;
	$$ = aux;	
}

somaexpressao : somaexpressao soma termo {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("somaexpressao");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	aux->filhos[aux->qtd++] = *((no*)$1);
	aux->filhos[aux->qtd++] = *((no*)$2);
	aux->filhos[aux->qtd++] = *((no*)$3);
	$$ = aux;
} | termo {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("somaexpressao");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	aux->filhos[aux->qtd++] = *((no*)$1);
	$$ = aux;
}

soma : MAIS {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("+");
	aux->qtd = 0;
	$$ = aux;
} | MENOS {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("-");
	aux->qtd = 0;
	$$ = aux;
}

termo : termo mult fator { 
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("termo");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	aux->filhos[aux->qtd++] = *((no*)$1);
	aux->filhos[aux->qtd++] = *((no*)$2);
	aux->filhos[aux->qtd++] = *((no*)$3);
	$$ = aux;
} | fator {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("termo");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	aux->filhos[aux->qtd++] = *((no*)$1);
	$$ = aux;
}

mult : VEZES {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("*");
	aux->qtd = 0;
	$$ = aux;
} | DIVISAO {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("/");
	aux->qtd = 0;
	$$ = aux;
}

fator : ABREPARENTESIS expressao FECHAPARENTESIS {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("fator");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
		no * f1 = (no*) malloc(sizeof(no));
		f1->nome = strdup("(");
		f1->qtd = 0;
		no * f2 = (no*) malloc(sizeof(no));
		f2->nome = strdup(")");
		f2->qtd = 0;
	aux->filhos[aux->qtd++] = *f1;
	aux->filhos[aux->qtd++] = *((no*)$2);
	aux->filhos[aux->qtd++] = *f2;
	$$ = aux;
} | variavel {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("fator");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	aux->filhos[aux->qtd++] = *((no*)$1);
	$$ = aux;
} | ativacao {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("fator");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	aux->filhos[aux->qtd++] = *((no*)$1);
	$$ = aux;
} | NUM {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("fator");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	aux->filhos[aux->qtd++] = *((no*)$1);
	$$ = aux;
}

ativacao : ID ABREPARENTESIS argumentos FECHAPARENTESIS {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("ativacao");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	no * f1 = (no*) malloc(sizeof(no));
	f1->nome = strdup("ID");
	f1->qtd = 0;
	no * f2 = (no*) malloc(sizeof(no));
	f2->nome = strdup("(");
	f2->qtd = 0;
	no * f3 = (no*) malloc(sizeof(no));
	f3->nome = strdup(")");
	f3->qtd = 0;
	aux->filhos[aux->qtd++] = *f1;
	aux->filhos[aux->qtd++] = *f2;
	aux->filhos[aux->qtd++] = *((no*)$3);
	aux->filhos[aux->qtd++] = *f3;

	$$ = aux;
}
argumentos : listaargumentos {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("argumentos");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	aux->filhos[aux->qtd++] = *((no*)$1);
	$$ = aux;
} | /*epsilon*/ {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("argumentos");
	aux->qtd = 0;
	$$ = aux;
}

listaargumentos : listaargumentos VIRGULA expressao {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("listaargumentos");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	no * f1 = (no*) malloc(sizeof(no));
	f1->nome = strdup(",");
	f1->qtd = 0;
	aux->filhos[aux->qtd++] = *((no*)$1);
	aux->filhos[aux->qtd++] = *f1;
	aux->filhos[aux->qtd++] = *((no*)$3);
	$$ = aux;
} | expressao {
	no * aux = (no*) malloc(sizeof(no));
	aux->nome = strdup("listaargumentos");
	aux->filhos = (no*)malloc(sizeof(no) * 100);
	aux->qtd = 0;
	aux->filhos[aux->qtd++] = *((no*)$1);
	$$ = aux;
}

%%

int main(void) {
    yyparse();
}
