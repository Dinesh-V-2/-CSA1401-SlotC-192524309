%{
#include <stdio.h>
%}

%option noyywrap

%%

"//".*                      { printf("[COMMENT   ]: Single-line\n"); }
"/*"([^*]|\*+[^*/])*"*/"    { printf("[COMMENT   ]: Multi-line\n"); }

[ \t\n\r]+                 { /* Ignore redundant spaces, tabs, newlines */ }

"int"|"float"|"char"|"if"|"else"|"while"|"for"|"return" {
    printf("[KEYWORD   ]: %s\n", yytext);
}

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("[IDENTIFIER]: %s\n", yytext);
}

[0-9]+(\.[0-9]+)? {
    printf("[NUMBER    ]: %s\n", yytext);
}

"+"|"-"|"*"|"/"|"="|"=="|";"|","|"("|")"|"{"|"}" {
    printf("[OPERATOR  ]: %s\n", yytext);
}

. {
    printf("[UNKNOWN   ]: %s\n", yytext);
}

%%

int main() {
    printf("Enter code input:\n");
    yylex();
    return 0;
}