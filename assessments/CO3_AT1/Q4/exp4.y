%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

#define MAX_TYPES 50
#define MAX_VARS 50

typedef struct
{
    char name[20];
    char type[20];
} TypeEntry;

typedef struct
{
    char name[20];
    char type[20];
} VarEntry;

TypeEntry typeTable[MAX_TYPES];
VarEntry varTable[MAX_VARS];

int typeCount = 0;
int varCount = 0;

void addType(char *name, char *type);
void addVariable(char *name, char *type);
char* getType(char *name);
void checkEquivalence(char *type1, char *type2);

%}

%union
{
    char *str;
}

%token TYPE INT
%token <str> ID

%%

program:
        statements
        {
            printf("\nType checking completed.\n");
        }
        ;

statements:
        statements statement
        | statement
        ;

statement:
        TYPE ID '=' INT ';'
        {
            addType($2, "int");
            printf("Type declaration: %s = int\n", $2);
        }
        |
        ID ID ';'
        {
            addVariable($2, $1);

            printf("Variable declaration: %s %s\n",
                   $1, $2);
        }
        ;

%%

void addType(char *name, char *type)
{
    strcpy(typeTable[typeCount].name, name);
    strcpy(typeTable[typeCount].type, type);

    typeCount++;
}

void addVariable(char *name, char *type)
{
    strcpy(varTable[varCount].name, name);
    strcpy(varTable[varCount].type, type);

    varCount++;
}

char* getType(char *name)
{
    int i;

    for(i = 0; i < typeCount; i++)
    {
        if(strcmp(typeTable[i].name, name) == 0)
            return typeTable[i].type;
    }

    return name;
}

void checkEquivalence(char *type1, char *type2)
{
    char *base1 = getType(type1);
    char *base2 = getType(type2);

    printf("\nType comparison:\n");

    printf("Type 1: %s\n", type1);
    printf("Type 2: %s\n", type2);

    if(strcmp(type1, type2) == 0)
        printf("Name Equivalence: YES\n");
    else
        printf("Name Equivalence: NO\n");

    if(strcmp(base1, base2) == 0)
        printf("Structural Equivalence: YES\n");
    else
        printf("Structural Equivalence: NO\n");
}

void yyerror(const char *s)
{
    printf("Error: %s\n", s);
}

int main()
{
    printf("Enter type and variable declarations:\n");

    yyparse();

    printf("\nChecking A and B:\n");

    checkEquivalence("A", "B");

    return 0;
}