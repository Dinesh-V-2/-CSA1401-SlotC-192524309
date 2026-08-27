%{
#include <stdio.h>

int plus = 0;
int minus = 0;
int multiply = 0;
int divide = 0;
int modulus = 0;
%}

%%
"+"       { plus++; }
"-"       { minus++; }
"*"       { multiply++; }
"/"       { divide++; }
"%"       { modulus++; }

[ \t\n]+  ;
.         ;
%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter the C source program:\n");
    yylex();

    printf("\nArithmetic Operator Count:\n");
    printf("+ : %d\n", plus);
    printf("- : %d\n", minus);
    printf("* : %d\n", multiply);
    printf("/ : %d\n", divide);
    printf("%% : %d\n", modulus);

    printf("\nTotal Arithmetic Operators = %d\n",
           plus + minus + multiply + divide + modulus);

    return 0;
}