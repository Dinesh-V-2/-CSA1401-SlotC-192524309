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
          printf("Result = %d\n", $1);
      }
      ;

expr:
      expr '+' expr
      {
          $$ = $1 + $3;
      }
    | expr '*' expr
      {
          $$ = $1 * $3;
      }
    | NUMBER
      {
          $$ = $1;
      }
    ;

%%

void yyerror(const char *s)
{
    printf("Error: %s\n", s);
}

int main()
{
    printf("Enter an arithmetic expression: ");
    yyparse();
    return 0;
}