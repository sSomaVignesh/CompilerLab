%{
#include "my_scanner.h"
%}

%%
\:                      return COLON;
"db_type"               return TYPE;
"db_name"               return NAME;
"db_table_prefix"       return TABLE_PREFIX;
"db_port"               return PORT;
[a-zA-Z][0-9a-zA-Z_]*   return IDENTIFIER;
[1-9][0-9]*             return INTEGER;
[ \t\n]                 ;
.                       printf("Unidentifiable charachter\n");
%%

int yywrap(void){
    return 1;
}