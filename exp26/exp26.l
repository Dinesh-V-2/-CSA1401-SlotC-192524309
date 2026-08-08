%{
#include <stdio.h>
int is_valid = 0;
%}

%%

    /* Regular expression for a standard valid email format */
[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}   { is_valid = 1; }

    /* Match any other string/characters */
.|\n                                            ;

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter an email address: ");
    yylex();

    if (is_valid) {
        printf("Result: Valid Email Address\n");
    } else {
        printf("Result: Invalid Email Address\n");
    }

    return 0;
}