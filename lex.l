%{
#include "y.tab.h"
%}

%%
"if"            { printf("IF detected\n"); return IF; }
"else"          { printf("ELSE detected\n"); return ELSE; }
"("             { return LPAREN; }
")"             { return RPAREN; }
[a-zA-Z][a-zA-Z0-9]*    { printf("%s\n",yytext);return ID; }
[ \n\t]         ;
.               ;

%%

int yywrap() {
    return 1;
}
