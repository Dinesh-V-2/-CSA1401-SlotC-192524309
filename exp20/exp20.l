%{
#include <stdio.h>
%}

%option noyywrap

%%

    /* 1. Ignore comments */
"/*"([^*]|\*+[^/*])*\*+"/"   { /* Ignore multi-line comments */ }
"//".*                      { /* Ignore single-line comments */ }

    /* 2. String Literals (e.g., "Hello, World!") */
\"([^"\\]|\\.)*\"           { printf("String Constant     : %s\n", yytext); }

    /* 3. Character Constants (e.g., 'a', '\n') */
\'([^'\\]|\\.)*\'           { printf("Character Constant  : %s\n", yytext); }

    /* 4. Floating Point Constants (e.g., 3.14, .5, 2.0e-3) */
[0-9]*\.[0-9]+([eE][+-]?[0-9]+)?[fF]?  { printf("Float Constant      : %s\n", yytext); }
[0-9]+\.[0-9]*([eE][+-]?[0-9]+)?[fF]?  { printf("Float Constant      : %s\n", yytext); }

    /* 5. Hexadecimal / Octal / Decimal Integer Constants */
0[xX][0-9a-fA-F]+[uULl]*    { printf("Hex Integer Constant: %s\n", yytext); }
0[0-7]+[uULl]*              { printf("Oct Integer Constant: %s\n", yytext); }
[0-9]+[uULl]*               { printf("Integer Constant    : %s\n", yytext); }

    /* 6. Ignore white spaces, newlines, and other C syntax (identifiers, operators, etc.) */
[ \t\n]+                    { /* Skip whitespace */ }
.                           { /* Skip all other characters */ }

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

    printf("--- Found Constants ---\n");
    yylex();
    fclose(yyin);
    return 0;
}