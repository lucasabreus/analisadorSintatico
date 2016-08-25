all:
	yacc -o sintatic.c sintatic.y -d

	flex -o lex.yy.c lexico.l

	yacc -o sintatic.c sintatic.y 

	gcc -o bin sintatic.c -ll -ly 

	./bin < entradas/mdc.comp