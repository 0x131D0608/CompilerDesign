/* Definitions */

%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <ctype.h>

#include "temp.tab.h"

%}

id		[A-Za-z_][A-Za-z0-9_]*
intnum		[0-9]+
floatnum	[0-9]+"."[0-9]+
space		[ \t\r\n]

/* Rules */

%%

for		{	printf("\nfor\n");
			return FOR;
		}
while		{	printf("\nwhile\n");
			return WHILE;
		}
do		{	printf("\ndo\n");
			return DO;
		}
if		{	printf("\nif\n");
			return IF;
		}
else		{	printf("\nelse\n");
			return ELSE;
		}
class		{	printf("\nclass\n");
			return CLASS;
		}
public		{	printf("\npublic\n");
			return PUBLIC;
		}
private		{	printf("\nprivate\n");
			return PRIVATE;
		}
int		{	printf("\nint\n");
			return INT;
		}
float		{	printf("\nfloat\n");
			return FLOAT;
		}
main		{	printf("\nmain\n");
			return MAIN;
		}
return		{	printf("\nreturn\n");
			return RETURN;
		}
{id}		{ 	printf("\n%s\n", yytext);
			return ID;
		}
{intnum}	{	printf("\nintnum, %d\n", atoi(yytext));
			yylval = atoi(yytext);
			return INTNUM;
		}
{floatnum}	{	printf("\nfloatnum, %f\n", atof(yytext));
			yylval = atof(yytext);
			return FLOATNUM;
		}
"("		{	printf("\n%s\n", yytext);
			return L_PAR;
		}
")"		{	printf("\n%s\n", yytext);
			return R_PAR;
		}
"{"		{	printf("\n%s\n", yytext);
			return L_PAR2;
		}
"}"		{	printf("\n%s\n", yytext);
			return R_PAR2;
		}
"["		{	printf("\n%s\n", yytext);
			return L_PAR3;
		}
"]"		{	printf("\n%s\n", yytext);
			return R_PAR3;
		}
"*"		{	printf("\n%s\n", yytext);
			return MULT;
		}
"/"		{	printf("\n%s\n", yytext);
			return DIVIDE;
		}
"+"		{	printf("\n%s\n", yytext);
			return PLUS;
		}
"-"		{	printf("\n%s\n", yytext);
			return MINUS;
		}
"<"		{	printf("\n%s\n", yytext);
			return LT;
		}
">"		{	printf("\n%s\n", yytext);
			return GT;
		}
"<="		{	printf("\n%s\n", yytext);
			return LTE;
		}
">="		{	printf("\n%s\n", yytext);
			return GTE;
		}
"=="		{	printf("\n%s\n", yytext);
			return EQ;
		}	
"!="		{	printf("\n%s\n", yytext);
			return NEQ;
		}
"="		{	printf("\n%s\n", yytext);
			return ASSIGN;
		}
";"		{	printf("\n%s\n", yytext);
			return SEMI;
		}
"."		{	printf("\n%s\n", yytext);
			return DOT;
		}
","		{	printf("\n%s\n", yytext);
			return COMMA;
		}
":"		{	printf("\n%s\n", yytext);
			return COLON;
		}
"::"		{	printf("\n%s\n", yytext);
			return SCOPE;
		}
{space}		{	
			;	
		}

%%

/* User Code */
/*
int main() {

	int token;
	while ((token = yylex()) != 0)
		printf("Token : %d (%s)\n", token, yytext);

	return 0;
}

*/


