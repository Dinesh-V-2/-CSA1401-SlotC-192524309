%{
#include <stdio.h>
%}

%%
"abc"       { printf("ABC"); }       /* Replace 'abc' with 'ABC' */
.           { putchar(yytext[0]); }  /* Match and print any other character as-is */
\n          { putchar('\n'); }       /* Retain newlines */
%%

int main() {
    printf("Enter input string: ");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}