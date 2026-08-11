%{
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%

"type"      { return TYPE; }
"int"       { return INT; }

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