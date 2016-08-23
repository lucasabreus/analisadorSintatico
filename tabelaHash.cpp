#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cctype>
#include <cstring>
#include <algorithm>
#include <vector>
#include <list>
#include <map>
#include <utility>
#include <queue>
#include <stack>
#include <sstream>
#include <set>
#include <cmath>

using namespace std;

#define INF 0x3F3F3F3F
#define PI 3.14159265358979323846
#define EPS 1e-10
#define lli long long int
#define llu unsigned long long int
#define matrix_i(tipo, lin, col, inic)vector< vector< tipo > > (lin, vector< tipo > (col, inic))
#define matrix_d(tipo)vector< vector< tipo > >
#define fore(var,inicio,final) for(int var=inicio;var<final;var++)
#define forit(it, var) for( it = var.begin(); it != var.end(); it++ )

#define tamanho 7
#define potencia 2

int hashCode ( string valor, int indice ){
	if ( indice == -1 ) return 0;

	int valorAsc = valor[indice];
	return (potencia*(hashCode(valor,indice-1)) + valorAsc) % tamanho;
}

int main () {
	string palavra;
	vector < vector <string> > hashTable(tamanho);
	while ( cin >> palavra ){
		hashTable[hashCode(palavra,palavra.size()-1)].push_back(palavra);
	}

	int dispersoes = 0;

	fore(i,0,hashTable.size()){
		cout << i << " :";
		if ( hashTable[i].size() > dispersoes) dispersoes = hashTable[i].size();
		fore(j,0,hashTable[i].size()){
			if ( j != 0 ) cout << " ";
			cout << hashTable[i][j];
		}
		cout << endl;
	}
	cout << "MÁXIMA DISPERSÃO: " << dispersoes << endl;
}