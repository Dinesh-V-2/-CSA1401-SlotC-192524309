%{
#include <stdio.h>
%}

%%

"//".*                     { printf("Single-line Comment\n"); }

"/*"([^*]|\*+[^*/])*\*+"/" { printf("Multi-line Comment\n"); }

.+                         { printf("Not a Comment\n"); }

%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter a line:\n");
    yylex();
    return 0;
}