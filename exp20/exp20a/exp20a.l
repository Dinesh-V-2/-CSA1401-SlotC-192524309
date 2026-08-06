%{
#include <stdio.h>

int header_count = 0;
int macro_count = 0;
%}

%option noyywrap

%%

    /* Match preprocessor directives */
"#"[ \t]*"include"[ \t]*[<"][^>\n"]+[>"]  { header_count++; }
"#"[ \t]*"define"[ \t]+[a-zA-Z_][a-zA-Z0-9_]* { macro_count++; }

    /* Ignore single-line and multi-line comments */
"//".*                                     { /* Ignore */ }
"/*"([^*]|\*+[^/*])*\*+"/"                 { /* Ignore */ }

    /* Ignore string literals to prevent matching '#include' inside strings */
\"([^"\\]|\\.)*\"                          { /* Ignore */ }

    /* Ignore all other characters and whitespaces */
.|\n                                       { /* Ignore */ }

%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            printf("Error: Could not open file %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    } else {
        printf("Usage: %s <filename.c>\n", argv[0]);
        return 1;
    }

    yylex();

    printf("\n--- Results ---\n");
    printf("Header Files Included : %d\n", header_count);
    printf("Macros Defined        : %d\n", macro_count);

    fclose(yyin);
    return 0;
}