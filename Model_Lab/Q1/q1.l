%{
#include <stdio.h>
%}

%%

"++"|"--"|"+"|"-"|"*"|"/"|"%" {
    printf("Arithmetic Operator: %s\n", yytext);
}

"=="|"!="|"<="|">="|"<"|">" {
    printf("Relational Operator: %s\n", yytext);
}

[ \t\n]+    ;
.           ;

%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter the C source program:\n");
    yylex();
    return 0;
}