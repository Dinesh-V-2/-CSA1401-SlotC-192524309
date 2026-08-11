%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token NUMBER

%left '+'
%left '*'

%%

input:
      expr '\n'
      {
          printf("\nFinal synthesized attribute = %d\n", $1);
      }
      ;

expr:
      expr '+' term
      {
          $$ = $1 + $3;

          printf("Reduction: expr -> expr + term\n");
          printf("$$ = $1 + $3 = %d + %d = %d\n",
                 $1, $3, $$);
      }
    | term
      {
          $$ = $1;

          printf("Reduction: expr -> term\n");
          printf("$$ = $1 = %d\n", $$);
      }
    ;

term:
      term '*' factor
      {
          $$ = $1 * $3;

          printf("Reduction: term -> term * factor\n");
          printf("$$ = $1 * $3 = %d * %d = %d\n",
                 $1, $3, $$);
      }
    | factor
      {
          $$ = $1;

          printf("Reduction: term -> factor\n");
          printf("$$ = $1 = %d\n", $$);
      }
    ;

factor:
      NUMBER
      {
          $$ = $1;

          printf("Reduction: factor -> NUMBER\n");
          printf("$$ = $1 = %d\n", $$);
      }
    ;

%%

void yyerror(const char *s)
{
    printf("Error: %s\n", s);
}

int main()
{
    printf("Enter expression: ");
    yyparse();

    return 0;
}