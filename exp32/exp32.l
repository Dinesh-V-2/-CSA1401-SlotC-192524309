%{
#include <stdio.h>

int positive_count = 0;
int negative_count = 0;
int zero_count = 0;
%}

%%

-[0-9]+(\.[0-9]+)? {
    printf("[NEGATIVE NUMBER] : %s\n", yytext);
    negative_count++;
}

\+?[1-9][0-9]*(\.[0-9]+)? |
\+?0\.[0-9]*[1-9][0-9]* {
    printf("[POSITIVE NUMBER] : %s\n", yytext);
    positive_count++;
}

\+?0+(\.0+)? {
    printf("[ZERO]            : %s\n", yytext);
    zero_count++;
}

[ \t\n]+ ; /* Ignore whitespace, tabs, and newlines */
.        ; /* Ignore any other non-numeric character */

%%

int main() {
    printf("Enter numbers separated by spaces or newlines:\n");
    printf("(Press Ctrl+Z then Enter on Windows, or Ctrl+D on Linux to finish)\n\n");
    
    yylex();
    
    printf("\n--- Results ---\n");
    printf("Positive Numbers : %d\n", positive_count);
    printf("Negative Numbers : %d\n", negative_count);
    printf("Zeroes           : %d\n", zero_count);
    
    return 0;
}

int yywrap() {
    return 1;
}