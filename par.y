%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char*);

#define YYSTYPE YYSTYPE
#define YYDEBUG 1

typedef struct {
    char* str;
} YYSTYPE;

%}

%token IF LPAREN RPAREN ELSE ID

%%
program : statement;

statement : if_statement
        | ID
        ;

if_statement : IF LPAREN e RPAREN statement 
        | IF LPAREN ID RPAREN statement ELSE statement
        ;


%%

void yyerror(const char *s) {
    printf("Error!\n");
    exit(0);
}

int main() {
    yyparse();
    printf("\nsuccess\n");
    return 0;
}
