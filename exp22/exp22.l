%{
#include <stdio.h>
%}

%%

    /* Pattern to match any HTML tag (opening, closing, or self-closing) */
"<"[^>]+">"   { printf("%s\n", yytext); }

    /* Ignore all other characters and newlines */
.|\n          ; 

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
        printf("Usage: ./a.out <filename.html>\n");
        return 1;
    }

    yylex();
    return 0;
}