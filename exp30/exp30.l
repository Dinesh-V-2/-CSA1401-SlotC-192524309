%{
#include <stdio.h>

int vowel_count = 0;
int consonant_count = 0;
%}

%%

[aeiouAEIOU] { 
    vowel_count++; 
}

[a-zA-Z] { 
    consonant_count++; 
}

[0-9 \t\n.,!?;:'"-] ; /* Ignore numbers, whitespaces, and punctuation marks */

. ;                  /* Ignore any other special characters */

%%

int main() {
    printf("Enter a word or sentence (Press Ctrl+D to evaluate):\n\n");
    yylex();
    
    printf("\n--- Class Activity Results ---\n");
    printf("Total Vowels     : %d\n", vowel_count);
    printf("Total Consonants : %d\n", consonant_count);
    
    return 0;
}

int yywrap() {
    return 1;
}