%{
#include <stdio.h>

int char_count = 0;
int word_count = 0;
int line_count = 0;
%}

/* Definitions */
%option noyywrap

%%

"/*"([^*]|\*+[^/*])*\*+"/"   { /* Ignore multi-line comments */ }
"//".*                      { /* Ignore single-line comments */ }

[ \t]+                      { /* Ignore redundant spaces and tabs */ }
\n                          { line_count++; /* Count lines, but ignore as words */ }

[a-zA-Z_][a-zA-Z0-9_]{0,31}  { 
                                /* Identifiers (restricted to 32 chars) */
                                word_count++; 
                                char_count += yyleng; 
                            }

[0-9]+(\.[0-9]+)?           { 
                                /* Numbers */
                                word_count++; 
                                char_count += yyleng; 
                            }

.                           { 
                                /* Any other character (operators, punctuation, etc.) */
                                char_count++; 
                            }

%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            printf("Error opening file: %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    } else {
        printf("Usage: %s <filename.c>\n", argv[0]);
        return 1;
    }

    yylex();

    printf("\n--- Results ---\n");
    printf("Total Lines      : %d\n", line_count);
    printf("Total Words      : %d\n", word_count);
    printf("Total Characters : %d\n", char_count);

    fclose(yyin);
    return 0;
}