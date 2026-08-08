%{
#include <stdio.h>
%}

/* Rules Section */
%%

"#include"[ ]*<[^>\n]+>   { printf("[HEADER FILE]      : %s\n", yytext); }
"#define"[ ]+.*          { printf("[PREPROCESSOR]     : %s\n", yytext); }

"int"|"float"|"char"|"double"|"void"|"return"|"if"|"else"|"while"|"for"|"do"|"break"|"continue"|"switch"|"case"|"struct"|"typedef" { 
    printf("[KEYWORD]          : %s\n", yytext); 
}

[a-zA-Z_][a-zA-Z0-9_]*  { printf("[IDENTIFIER]       : %s\n", yytext); }

[0-9]+\.[0-9]+           { printf("[FLOAT CONSTANT]   : %s\n", yytext); }
[0-9]+                  { printf("[INTEGER CONSTANT] : %s\n", yytext); }
\"([^\\\"]|\\.)*\"      { printf("[STRING LITERAL]   : %s\n", yytext); }
'([^\\']|\\.)'          { printf("[CHAR LITERAL]     : %s\n", yytext); }

"=="|"!="|"<="|">="|"&&"|"||"|"++"|"--"|"+"|"-"|"*"|"/"|"%"|"="|"<"|">" { 
    printf("[OPERATOR]         : %s\n", yytext); 
}

"{"|"}"|"("|")"|"["|"]"|";"|","|"." { 
    printf("[DELIMITER/PUNCT]  : %s\n", yytext); 
}

"/*"([^*]|\*+[^/*])*\*+"/"  ; /* Ignore multi-line comments */
"//".*                      ; /* Ignore single-line comments */
[ \t\n]+                    ; /* Ignore whitespaces, tabs, and newlines */

.                           { printf("[UNKNOWN TOKEN]    : %s\n", yytext); }

%%

int main() {
    printf("Enter C code snippet (Press Ctrl+D when finished):\n\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}