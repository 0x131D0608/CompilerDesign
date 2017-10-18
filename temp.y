/* Definitions */

%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

extern FILE *yyin;

%}

%token		ID INTNUM FLOATNUM
%token		FOR WHILE DO
%token		IF ELSE
%token 		CLASS PUBLIC PRIVATE
%token		INT FLOAT
%token		MAIN RETURN

%left		L_PAR2 R_PAR2 SEMI COLON COMMA
%left		EQ NEQ
%left		LT GT LTE GTE
%left		PLUS MINUS
%left 		MULT DIVIDE
%left		L_PAR R_PAR L_PAR3 R_PAR3 DOT
%left		SCOPE

%right		ASSIGN

%nonassoc	UMINUS

/* Rules */
%%

Start : 
	  Program		{ printf("Start->Program\n");}
	| ClassList Program	{ printf("Start->ClassList Program\n");}
	;

Program :
	  ClassMethodList MainFunc	{ printf("Program->ClassMethodList MainFunc\n");}
	| MainFunc		{ printf("Program->MainFunc\n");}
	;

ClassList :
	  Class {printf("ClassList->Class\n");}
	| Class ClassList	{printf("ClassList->Class ClassList\n");}
	;

Class :
	  CLASS ID L_PAR2 Class2 Class3 R_PAR2	{printf("Class -> CLASS ID {C2 C3}\n");}
	;
Class2 :
	  PRIVATE COLON Member	{printf("C2->PRIVATE : Member\n");}
	|	{printf("C2->NONE\n");}
	;
Class3 : 
	  PUBLIC COLON Member	{printf("C3->PUBLIC : Member\n");}
	|	{printf("C3->NONE\n");}
	;


Member :
	  VarDeclList Member1	{ printf("Member->VarDeclList Member1\n");}
	| Member1	{ printf("Member->Member1\n");}
	;
Member1 :
	  MethodDeclList Member2	{ printf("Member1->MethodDeclList Member2\n");}
	| Member2	{ printf("Member1->Member2\n");}
	;
Member2 :
	  MethodDefList	{ printf("Member2->MethodDefList\n");}
	| 	{ printf("Member2->NONE\n");}
	;

VarDeclList :
	  VarDecl	{printf("VarDeclList->VarDecl\n");}
	| VarDecl VarDeclList	{printf("VarDeclList->VarDecl VarDeclList\n");}
	;

MethodDeclList :
	  FuncDecl	{printf("MethodDeclList->FuncDecl\n");}
	| FuncDecl MethodDeclList	{printf("MethodDeclList->FuncDecl MethodDeclList\n");}
	;

MethodDefList :
	  FuncDef	{printf("MethodDefList->FuncDef\n");}
	| FuncDef MethodDefList	{printf("MethodDefList->FuncDef MethodDefList\n");}
	;

VarDecl :
	  Type Ident VarDecl2 SEMI	{printf("VarDecl->Type Ident VarDecl2 ;\n");}
	;
VarDecl2 :
	  ASSIGN INTNUM	{printf("VarDecl2->= INTNUM\n");}
	| ASSIGN FLOATNUM	{printf("VarDecl2->= FLOATNUM\n");}
	|	{printf("VarDecl2->NONE\n");}
	;


FuncDecl :
	  Type ID L_PAR FuncDecl2 R_PAR SEMI	{printf("FuncDecl->TYPE ID ( F2 ) ;\n");}
	;
FuncDecl2 :
	  ParamList	{printf("FuncDecl2->ParamList\n");}
	|	{printf("FuncDecl2->NONE\n");}
	;

FuncDef :
	  Type ID L_PAR FuncDecl2 R_PAR CompoundStmt	{printf("FuncDef->Type ID (F2 ) CompoundStmt\n");}
	;

ClassMethodList :
	  ClassMethodDef	{printf("ClassMethodList->ClassMethodDef\n");}
	| ClassMethodDef ClassMethodList	{printf("ClassMethodList->ClassMethodDef ClassMethodLIst\n");}
	;

ClassMethodDef :
	  Type ID SCOPE ID L_PAR FuncDecl2 R_PAR CompoundStmt {printf("ClassMethodDef-> Type ID :: ID ( FUncDecl2 ) CompoundStmt\n");}
	;

MainFunc :
	  INT MAIN L_PAR R_PAR CompoundStmt	{printf("MainFunc->INT MAIN ( ) CompoundStmt\n");}
	;

ParamList :
	  Param ParamList2	{printf("ParamList->Param ParamList2\n");}
	;
ParamList2 :
	  COMMA Param ParamList2	{printf("ParamList2->, Param ParamList2\n");}
	|	{printf("ParamLIst2->None\n");}
	;

Param :
	  Type Ident	{printf("Param->Type Ident\n");}
	;

Ident :
	  ID 	{printf("Ident->ID\n");}
	| ID L_PAR3 INTNUM R_PAR3	{printf("Ident->ID [INTNUM]\n");}
	;

Type :
	  INT	{printf("Type->INT\n");}
	| FLOAT	{printf("Type->FLOAT\n");}
	| ID	{printf("Type->ID\n");}
	;

CompoundStmt : 
	  L_PAR2 CompoundStmt2 CompoundStmt3 R_PAR2	{printf("CompoundStmt->{CompoundStmt2 CompountStmt3}\n");}
	;
CompoundStmt2 :
	  VarDeclList	{printf("Compound2->VarDeclList\n");}
	|	{printf("Compound2->NONE\n");}
	;
CompoundStmt3 :
	  StmtList	{printf("Compound3->StmtLIst\n");}
	|	{printf("Compound3->NONE\n");}
	;

StmtList :
	  Stmt	{printf("StmtLIst->Stmt\n");}
	| Stmt StmtList	{printf("StmtList->Stmt StmtList\n");}
	;

Stmt :
	  ExprStmt	{printf("Stmt->ExprStmt\n");}
	| AssignStmt	{printf("Stmt->AssignSTmt\n");}
	| RetStmt	{printf("STmt->retstmt\n");}
	| WhileStmt	{printf("Stmt->whileStmt\n");}
	| DoStmt	{printf("stmt->dostmt\n");}
	| ForStmt	{printf("stmt->ForStmt\n");}
	| IfStmt	{printf("stmt->IfStmt\n");}
	| CompoundStmt	{printf("Stmt->Compoundstmt\n");}
	| SEMI	{printf("stmt->;\n");}
	;

ExprStmt :
	  Expr SEMI	{printf("ExprStmt->expr ;\n");}
	;

AssignStmt :
	  RefVarExpr ASSIGN Expr SEMI	{printf("Assignment->Refvarexpr = expr ;\n");}
	;

RetStmt :
	  RETURN RetStmt2 SEMI	{printf("retstmt->return Retstmt2 ;\n");}
	;
RetStmt2 :
	  Expr	{printf("retstmt2-> expr\n");}
	|	{printf("retstmt2->none\n");}
	;

WhileStmt :
	  WHILE L_PAR Expr R_PAR Stmt	{printf("WhileStmt->While ( expr ) Stmt\n");}
	;

DoStmt :
	  DO Stmt WHILE L_PAR Expr R_PAR SEMI	{printf("DoStmt->Do stmt while (expr ) ;\n");}
	;

ForStmt :
	  FOR L_PAR Expr SEMI Expr SEMI Expr R_PAR Stmt	{printf("ForStmt->For ( E;E;E) Stmt\n");}
	;

IfStmt :
	  IF L_PAR Expr R_PAR Stmt IfStmt2	{printf("IfStmt->if (expr) stmt ifstmt2\n");}
	;
IfStmt2 :
	  ELSE Stmt	{printf("ifstmt2->else stmt\n");}
	|	{printf("ifstmt2->none\n");}
	;

Expr :
	  OperExpr	{printf("expr->operexpr\n");}
	| RefExpr	{printf("expr->refexpr\n");}
	| INTNUM	{printf("expr->intnum\n");}
	| FLOATNUM	{printf("expr->floatnum\n");}
	;

OperExpr :
	  UMINUS Expr	{printf("operexpr->unminus expr\n");}
	| Expr PLUS Expr	{printf("operexpr->expr+expr\n");}
	| Expr MINUS Expr	{printf("operexpr->expr-expr\n");}
	| Expr MULT Expr	{printf("operexpr->expr*expr\n");}
	| Expr DIVIDE Expr	{printf("operexpr->expr/expr\n");}
	| Expr LT Expr	{printf("operexpr->expr<expr\n");}
	| Expr GT Expr	{printf("operexpr->expr>expr\n");}
	| Expr LTE Expr	{printf("operexpr->expr<=expr\n");}
	| Expr GTE Expr	{printf("operexpr->expr>=expr\n");}
	| Expr EQ Expr	{printf("operexpr->expr==expr\n");}
	| Expr NEQ Expr	{printf("operexpr->expr!=expr\n");}
	| L_PAR Expr R_PAR	{printf("operexpr->( expr )\n");}
	;

RefExpr :
	  RefVarExpr 	{printf("refexpr->refvarexpr\n");}
	| RefCallExpr	{printf("refexpr->refcallexpr\n");}
	;

RefVarExpr :
	  RefExpr DOT IdentExpr	{printf("refvarexpr->refvarexpr2 identexpr\n");}
	| IdentExpr
	;

RefCallExpr :
	  RefExpr DOT CallExpr	{printf("refcallexpr->refvarexpr2 callexpr\n");}
	| CallExpr
	;

IdentExpr :
	  ID  L_PAR3 Expr R_PAR3	{printf("identexpr->id [ expr ]\n");}
	| ID	{printf("identexpr -> id\n");}
	;

CallExpr :
	  ID L_PAR CallExpr2 R_PAR	{printf("callexpr->id ( callexpr2 )\n");}
	;
CallExpr2 :
	  ArgList	{printf("callexpr2->arglist\n");}
	| 	{printf("callexpr2->none\n");}
	;

ArgList :
	  Expr ArgList2	{printf("arglist->expr arglist2\n");}
	;
ArgList2 :
	  COMMA Expr ArgList2	{printf("arglist2->, expr arglist2\n");}
	|	{printf("arglist2->none\n");}
	;

%%
/* User Code */

#include <ctype.h>

int yyerror(char *s) {

	return printf("%s\n", s);
}

int main(int argc, char *argv[]) {

	yyin = fopen(argv[1], "r");
	
	if (!yyparse()) {

		printf("Parsing Complete\n");
	}
	else {

		printf("Parsing Fail\n");
	}

	fclose(yyin);

	return 0;
}

