#include <stdio.h>
#include <string.h>

void eliminateLeftRecursion(char nonTerminal, char *rule) {
    char alpha[10][10], beta[10][10];
    int alphaCount = 0, betaCount = 0;

    // Tokenize the production rules separated by '/'
    char ruleCopy[100];
    strcpy(ruleCopy, rule);
    char *token = strtok(ruleCopy, "/");

    while (token != NULL) {
        // Check if token starts with the same non-terminal (Left Recursion)
        if (token[0] == nonTerminal) {
            strcpy(alpha[alphaCount++], token + 1); // Extract alpha part
        } else {
            strcpy(beta[betaCount++], token);      // Extract beta part
        }
        token = strtok(NULL, "/");
    }

    // If no left recursion was found, print rule as is
    if (alphaCount == 0) {
        printf("%c -> %s\n", nonTerminal, rule);
        return;
    }

    // Print A -> beta A' productions
    printf("%c -> ", nonTerminal);
    for (int i = 0; i < betaCount; i++) {
        printf("%s%c'", beta[i], nonTerminal);
        if (i < betaCount - 1) printf(" / ");
    }
    printf("\n");

    // Print A' -> alpha A' / # productions (# represents epsilon)
    printf("%c' -> ", nonTerminal);
    for (int i = 0; i < alphaCount; i++) {
        printf("%s%c' / ", alpha[i], nonTerminal);
    }
    printf("#\n"); // # denotes epsilon
}

int main() {
    int n;
    char nonTerminal;
    char rule[100];

    printf("Enter number of non-terminals: ");
    scanf("%d", &n);

    for (int i = 0; i < n; i++) {
        printf("\nEnter Non-Terminal (e.g., L): ");
        scanf(" %c", &nonTerminal);

        printf("Enter RHS productions separated by '/' (e.g., L,S/S or (L)/a): ");
        scanf("%s", rule);

        printf("\nResult for %c:\n", nonTerminal);
        eliminateLeftRecursion(nonTerminal, rule);
    }

    return 0;
}