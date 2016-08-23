# Analisador Sintático
Analisador sintático usando LEX e YACC

 * O arquivo 'arquivo.txt' é a entrada para o analisador léxico e sintático.


### Analisador léxico 
  - Palavras Chave:
      ```if else int void return while ```
  - Simbolos especiais: 
        ```+ - * / < <= > >= == != = ; , ( ) [ ]```  { } /* */ 
  - Identificadores ID e NUM:
    
    **Letra** ``` [a-z]|[A-Z] ```  
    **Dígito** ``` [0-9]```  
    **ID** ``` {Letra}{letra}*```  
    **NUM** ``` {Dígito}{Dígito}*```  

### Analisador sintático ( Gramática ) 
```
<programa> ::= <lista_declarações>
<lista_declarações> ::= <lista_declarações> <declaração> | <declaração>
<declaração> ::= <declaração_variáveis> | <declaração_funções>
<declaração_variáveis> ::= <tipo> ID ; | <tipo> ID [ NUM ] ;
<tipo> ::= int | void
<declaração_funções> ::= <tipo> ID ( <parâmetros> ) <declaração_composta>
<parâmetros> ::= <lista_parâmetros> | void
<lista_parâmetros> :: = <lista_parâmetros> , <param> | <param>
<param> ::= <tipo> ID | <tipo> ID [ ]
<declaração_composta> ::= { <declarações_locais> <lista_comandos> }
<declarações_locais> ::= <declarações_locais> <declaração_variáveis> | ε
<lista_comandos> ::= <lista_comandos> <comando> | ε
<comando> ::= <declaração_expressão> | <declaração_composta> | <declaração_seleção> |
<declaração_iteração> | <declaração_retorno> 

<declaração_expressão> ::= <expressão> ; | ;
<declaração_seleção> ::= if ( <expressão> ) <comando> | if ( <expressão> ) <comando> else <comando> 
<declaração_iteração> ::= while ( <expressão> ) <comando>
<declaração_retorno> ::= return ; | return <expressão> ;

<expressão> ::= <variável> = <expressão> | <expressão_simples>
<variável> ::= ID | ID [ <expressão> ]
<expressão_simples> ::= <soma_expressão> <op_relacional> <soma_expressão> | <soma_expressão> ::= <soma_expressão> <soma> <termo> | <termo>
<op_relacional> ::= <= | < | > | >= | == | !=
<soma> ::= + | –
<termo> ::= <termo> <mult> <fator> | <fator>
<mult> ::= * | /
<fator> ::= ( <expressão> ) | <variável> | <ativação> | NUM 
<ativação> ::= ID ( <argumentos> )
<argumentos> ::= <lista_argumentos> | ε
<lista_argumentos> ::= <lista_argumentos> , <expressão> | <expressão>
```

### Entrada
	int global;

    int teste ( int a ){
		int c;
    }

### Saída ( Árvore )
	programa
    listadeclaracoes
        listadeclaracoes
            declaracao
                declaracaoVariaveis
                    TIPO
                    ID
                    ;
        declaracao
            declaracaofuncoes
                TIPO
                ID
                (
                parametros
                    listaparametros
                        param
                            TIPO
                            ID
                )
                declaracaocomposta
                    {
                    declaracoeslocais
                        declaracoeslocais
                        declaracaoVariaveis
                            TIPO
                            ID
                            ;
                    listacomandos
                    }


### Execução

Para executar será necessário ter instalado o Flex ou Lex [FLEX](http://flex.sourceforge.net/), [YACC](http://dinosaur.compilertools.net/yacc/) e [GCC](https://gcc.gnu.org/)

- separadamente
``` 
	yacc -o sintatic.c sintatic.y -d

	flex -o lex.yy.c lexico.l

	yacc -o sintatic.c sintatic.y 

	gcc -o bin sintatic.c -ll -ly 

	./bin < arquivo.txt
```
- Usando MAKE FILE

``` 
	make 
```
