#include <stdio.h>
#include "my_scanner.h"

// Defined in lex.yy.c and we are going to use these by using "extern"
extern int yylex();
extern int yylineno;
extern char*yytext;

char*names[]={NULL,"db_type","db_name","db_table_prefix","db_port"};

int main(void){
    int nt,vt;
    nt = yylex(); // returns the first valid token
    while(nt) {
        printf("%d\n",nt);
        if (yylex() != COLON){
            printf("Error in line %d, Expected a ':' but found %s\n",yylineno,yytext);
            return 1;
        }
        vt = yylex();
        switch (nt) {
            case TYPE :
            case NAME :
            case TABLE_PREFIX :
                    if(vt!=IDENTIFIER){
                        printf("Error in line %d, Expected an identifier but found %s\n",yylineno,yytext);
                        return 1;
                    }
                    printf("%s is set to %s\n",names[nt],yytext);
                    break;
            case PORT:
                    if(vt!=INTEGER){
                        printf("Error in line %d, Expected an integer but found %s\n",yylineno,yytext);
                        return 1;
                    }
                    printf("%s is set to %s\n",names[nt],yytext);   
                    break;
            default:
                    printf("Syntax error in line %d\n",yylineno);
        }
        nt = yylex();
    }
    return 0;
}