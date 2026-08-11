%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

typedef struct Node
{
    char value[20];
    struct Node *left;
    struct Node *right;
} Node;

Node* createNode(char *value, Node *left, Node *right);
void preorder(Node *root);
void inorder(Node *root);
void postorder(Node *root);
void printTree(Node *root, int level);

%}

%union
{
    char *str;
    void *node;
}

%token <str> ID
%type <node> expr

%left '+'
%left '*'

%%

input:
      expr '\n'
      {
          Node *root = (Node *)$1;

          printf("\nAST:\n");
          printTree(root, 0);

          printf("\nPreorder: ");
          preorder(root);

          printf("\nInorder: ");
          inorder(root);

          printf("\nPostorder: ");
          postorder(root);

          printf("\n");
      }
      ;

expr:
      expr '+' expr
      {
          $$ = (void *)createNode("+",
                    (Node *)$1,
                    (Node *)$3);
      }
    | expr '*' expr
      {
          $$ = (void *)createNode("*",
                    (Node *)$1,
                    (Node *)$3);
      }
    | ID
      {
          $$ = (void *)createNode($1, NULL, NULL);
      }
    ;

%%

Node* createNode(char *value, Node *left, Node *right)
{
    Node *newNode;

    newNode = (Node *)malloc(sizeof(Node));

    if(newNode == NULL)
    {
        printf("Memory allocation failed\n");
        exit(1);
    }

    strcpy(newNode->value, value);

    newNode->left = left;
    newNode->right = right;

    return newNode;
}

void preorder(Node *root)
{
    if(root == NULL)
        return;

    printf("%s ", root->value);

    preorder(root->left);
    preorder(root->right);
}

void inorder(Node *root)
{
    if(root == NULL)
        return;

    inorder(root->left);

    printf("%s ", root->value);

    inorder(root->right);
}

void postorder(Node *root)
{
    if(root == NULL)
        return;

    postorder(root->left);
    postorder(root->right);

    printf("%s ", root->value);
}

void printTree(Node *root, int level)
{
    int i;

    if(root == NULL)
        return;

    for(i = 0; i < level; i++)
        printf("    ");

    printf("%s\n", root->value);

    printTree(root->left, level + 1);
    printTree(root->right, level + 1);
}

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