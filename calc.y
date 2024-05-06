%{
void yyerror(char* s);
#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>
int symbols[52];
int SymbolVal(char symbol);
void UpdateSymbolVal(char symbol,int val);    
void PrintSymbolTable();
%}

%union{int num; char id;}    /*Yacc defintions*/
%start line
%token print 
%token exit_command
%token <num> number
%token <id> identifier
%type <num> line exp term
%type <id> assignment

%%
line : assignment ';'               {;}
     | exit_command ';'             {exit(EXIT_SUCCESS);}
     | print exp ';'                {printf("Printing %d\n",$2);}
     | line assignment ';'          {;}
     | line print exp ';'           {printf("Printing %d\n",$3);}
     | line exit_command ';'        {exit(EXIT_SUCCESS);}
     ;

assignment : identifier '=' exp     {UpdateSymbolVal($1,$3);}
           ;

exp : term                          {$$=$1;}
    | exp '+' term                  {$$=$1+$3;}
    | exp '-' term                  {$$=$1-$3;}
    ;

term:number                         {$$=$1;}
    |identifier                     {$$=SymbolVal($1);}
    ;
%%

// C code 

int ComputeSymbolIndex(char token){
    int index = -1;
    if(islower(token)){
        index = token - 'a' +26;
    }
    else if (isupper(token)){
        index = token -'A';
    }
    return index;
}

int SymbolVal(char symbol) {
    int i = ComputeSymbolIndex(symbol);
    return symbols[i];
}

void UpdateSymbolVal(char symbol,int val){
    int i = ComputeSymbolIndex(symbol);
    symbols[i]=val;
    PrintSymbolTable();
}

void PrintSymbolTable(){
    printf("Token\t Type\t\t Value\n");
    for(int i=0;i<52;i++){
        if(symbols[i]!=0){
            printf("%d\t identifier\t %d \n",i,symbols[i]);
        }
    }
    printf("\n");
}

int main(void){
    for(int i=0;i<52;i++){
        symbols[i]=0;
    }
    return yyparse();
}

void yyerror(char*s){fprintf(stderr,"%s\n",s);}