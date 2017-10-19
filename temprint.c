#include <stdio.h>

#include "AST.h"

FILE *fptr;

int main() {

	fptr = fopen("temp.result", "w");

	if (!yyparse()) {

		dfs();
	}

	fprintf(fptr, "\n");
	
	fclose(fptr);

	return 0;
}
