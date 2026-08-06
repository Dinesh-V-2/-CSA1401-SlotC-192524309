%{
#include <stdio.h>

int comment_count = 0;
FILE *out_file;
%}

%x MULTI_LINE_COMMENT

%%

    /* Single-line comments: match until end of line */
"//".*                    { comment_count++; }

    /* Multi-line comments: enter dedicated state */
"/*"                      { comment_count++; BEGIN(MULTI_LINE_COMMENT); }
<MULTI_LINE_COMMENT>"*/"  { BEGIN(INITIAL); }
<MULTI_LINE_COMMENT>\n    { /* keep newlines if you want to preserve line numbers, or leave empty */ }
<MULTI_LINE_COMMENT>.     { /* skip comment text */ }

    /* All other characters: write directly to output file */
.|\n                      { fputc(yytext[0], out_file); }

%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("Usage: ./a.out <input_file.c> <output_file.c>\n");
        return 1;
    }

    FILE *in_file = fopen(argv[1], "r");
    if (!in_file) {
        printf("Error: Cannot open input file %s\n", argv[1]);
        return 1;
    }

    out_file = fopen(argv[2], "w");
    if (!out_file) {
        printf("Error: Cannot create output file %s\n", argv[2]);
        fclose(in_file);
        return 1;
    }

    yyin = in_file;
    yylex();

    fclose(in_file);
    fclose(out_file);

    printf("\nTotal comments eliminated: %d\n", comment_count);
    printf("Cleaned code saved to: %s\n", argv[2]);

    return 0;
}