%{
#include <stdio.h>
int count = 0;
%}

%%

    /* Match words consisting only of uppercase letters A-Z */
[A-Z]+    { printf("Capital Word: %s\n", yytext); count++; }

    /* Ignore all other words, characters, and whitespace */
.|\n      ; 

%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            printf("Error: Could not open file %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    } else {
        printf("Enter text (Press Ctrl+Z on Windows / Ctrl+D on Linux and Enter to stop):\n");
    }

    yylex();
    printf("\nTotal capital words found: %d\n", count);
    return 0;
}