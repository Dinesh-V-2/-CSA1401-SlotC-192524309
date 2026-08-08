%{
#include <stdio.h>
%}

%%
[6-9][0-9]{9}    { printf("Valid Mobile Number: %s\n", yytext); }
[0-9]+          { printf("Invalid Mobile Number (Incorrect format/length): %s\n", yytext); }
[ \t\n]+        ; /* Ignore whitespace, tabs, and newlines */
.               { printf("Invalid Input (Contains non-numeric characters): %s\n", yytext); }
%%

int main() {
    printf("Enter mobile numbers to verify (Press Ctrl+D to finish):\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}