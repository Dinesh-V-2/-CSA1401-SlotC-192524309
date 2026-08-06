%{
#include <stdio.h>
int line_number = 1;
%}

%%

\n    { putchar('\n'); printf("%4d  ", line_number++); }
.     { putchar(yytext[0]); }

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
        printf("Usage: ./a.out <program.c>\n");
        return 1;
    }

    printf("%4d  ", line_number++);
    yylex();
    printf("\n");
    return 0;
}