%{
#include <stdio.h>
%}

%%

"+"         { printf("Valid Operator: PLUS (+)\n"); }
"-"         { printf("Valid Operator: MINUS (-)\n"); }
"*"         { printf("Valid Operator: MULTIPLY (*)\n"); }
"/"         { printf("Valid Operator: DIVIDE (/)\n"); }

[ \t\n]+    { /* Ignore whitespace, tabs, and newlines */ }
.           { printf("Invalid / Unrecognized character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter arithmetic expressions or operators to analyze:\n");
    yylex();
    return 0;
}