%{
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%

"int"       { return INT; }
"float"     { return FLOAT; }

[A-Za-z][A-Za-z0-9_]* {
                            yylval.str = strdup(yytext);
                            return ID;
                        }

"="         { return '='; }
";"         { return ';'; }

[ \t\n]     ;

.           { return yytext[0]; }

%%

int yywrap()
{
    return 1;
}