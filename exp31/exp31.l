%{
#include <stdio.h>

int keyword_count = 0;
int identifier_count = 0;
%}

%%

"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while" {
    printf("[KEYWORD]    : %s\n", yytext);
    keyword_count++;
}

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("[IDENTIFIER] : %s\n", yytext);
    identifier_count++;
}

[0-9]+                  ;
[ \t\n]+                ;
.                       ;

%%

int main() {
    printf("Enter input C code (Press Ctrl+D on Linux or Ctrl+Z then Enter on Windows to finish):\n\n");
    yylex();
    
    printf("\n--- Summary ---\n");
    printf("Total Keywords    : %d\n", keyword_count);
    printf("Total Identifiers : %d\n", identifier_count);
    return 0;
}

int yywrap() {
    return 1;
}