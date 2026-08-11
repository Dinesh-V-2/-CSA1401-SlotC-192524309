%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

#define MAX 50

typedef struct
{
    char name[30];
    char type[10];
} Symbol;

Symbol table[MAX];
int count = 0;

void addSymbol(char *name, char *type);
char* lookup(char *name);
void assignType(char *lhs, char *rhs);

%}

%union
{
    char *str;
}

%token INT FLOAT
%token <str> ID

%%

program:
        statements
        {
            printf("\nSemantic analysis completed.\n");
        }
        ;

statements:
        statements statement
        | statement
        ;

statement:
        INT ID ';'
        {
            addSymbol($2, "int");

            printf("Declared: int %s\n", $2);
        }
        |
        FLOAT ID ';'
        {
            addSymbol($2, "float");

            printf("Declared: float %s\n", $2);
        }
        |
        ID '=' ID ';'
        {
            assignType($1, $3);
        }
        ;

%%

void addSymbol(char *name, char *type)
{
    strcpy(table[count].name, name);
    strcpy(table[count].type, type);

    count++;
}

char* lookup(char *name)
{
    int i;

    for(i = 0; i < count; i++)
    {
        if(strcmp(table[i].name, name) == 0)
            return table[i].type;
    }

    return NULL;
}

void assignType(char *lhs, char *rhs)
{
    char *leftType = lookup(lhs);
    char *rightType = lookup(rhs);

    printf("\nAssignment: %s = %s\n", lhs, rhs);

    printf("Left-hand type  : %s\n", leftType);
    printf("Right-hand type : %s\n", rightType);

    if(strcmp(leftType, rightType) == 0)
    {
        printf("Types are identical.\n");
        printf("No conversion required.\n");
    }
    else if(strcmp(leftType, "float") == 0 &&
            strcmp(rightType, "int") == 0)
    {
        printf("Type conversion required.\n");
        printf("Implicit conversion: int -> float\n");
        printf("Assignment is valid.\n");
    }
    else
    {
        printf("Type mismatch.\n");
        printf("Assignment is invalid.\n");
    }
}

void yyerror(const char *s)
{
    printf("Error: %s\n", s);
}

int main()
{
    printf("Enter declarations and assignment:\n");

    yyparse();

    return 0;
}