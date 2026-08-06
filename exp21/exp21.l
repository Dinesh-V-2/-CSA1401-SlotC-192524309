%{
#include <stdio.h>

int vowel_count = 0;
%}

%option noyywrap

%%

    /* Match all lowercase and uppercase vowels */
[aeiouAEIOU]    { vowel_count++; }

    /* Match any other character (consonants, spaces, punctuation, newlines) and ignore */
.|\n            { /* Skip */ }

%%

int main() {
    printf("Enter a sentence: ");
    yylex();

    printf("\n--- Results ---\n");
    printf("Total Vowels Count: %d\n", vowel_count);

    return 0;
}