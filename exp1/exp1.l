%{
#include <stdio.h>
#include <string.h>

#define MAX_IDENT_LEN 31
%}

/* Regular Definitions */
DIGIT       [0-9]
LETTER      [a-zA-Z_]
ID          {LETTER}({LETTER}|{DIGIT})*
INT_CONST   {DIGIT}+
FLOAT_CONST {DIGIT}+\.{DIGIT}+([eE][+-]?{DIGIT}+)?

%x MULTI_LINE_COMMENT

%%

 /* 1. IGNORE WHITESPACE (Spaces, Tabs, Newlines) */
[ \t\n\r]+  { /* Ignore redundant whitespaces */ }

 /* 2. IGNORE COMMENTS */
"//".*      { /* Ignore single-line comments */ }

"/*"        { BEGIN(MULTI_LINE_COMMENT); }
<MULTI_LINE_COMMENT>"*/" { BEGIN(INITIAL); }
<MULTI_LINE_COMMENT>.|\n { /* Ignore everything inside multi-line comments */ }

 /* 3. IDENTIFIERS (With length restriction check) */
{ID}        {
                if (yyleng > MAX_IDENT_LEN) {
                    printf("[WARNING] Identifier '%s' exceeds maximum allowed length (%d characters).\n", yytext, MAX_IDENT_LEN);
                } else {
                    printf("[IDENTIFIER]: %s\n", yytext);
                }
            }

 /* 4. CONSTANTS (Integer and Floating-point) */
{FLOAT_CONST}   { printf("[CONSTANT (Float)]: %s\n", yytext); }
{INT_CONST}     { printf("[CONSTANT (Integer)]: %s\n", yytext); }

 /* 5. OPERATORS (Arithmetic, Relational, Logical, Assignment) */
"=="|"!="|"<="|">="|"&&"|"||"|"++"|"--"  { printf("[OPERATOR]: %s\n", yytext); }
"+"|"-"|"*"|"/"|"%"|"="|"<"|">"|"!"      { printf("[OPERATOR]: %s\n", yytext); }

 /* Catch-all for punctuation/unknown characters */
.           { printf("[SYMBOL]: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Error opening file: %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    } else {
        printf("Reading from standard input (Press Ctrl+D to stop)...\n");
    }

    yylex();
    return 0;
}