#include <stdio.h>
#include <ctype.h>
#include <string.h>

int main() {
    int n;
    char g[20][20];

    printf("Enter number of rules: ");
    scanf("%d", &n);

    printf("Enter rules (e.g. S=AaAb, A=# for epsilon):\n");
    for (int i = 0; i < n; i++) {
        scanf("%s", g[i]);
    }

    printf("\n--- FOLLOW SETS ---\n");

    // Loop through each rule to check non-terminals on LHS
    for (int i = 0; i < n; i++) {
        char nt = g[i][0];
        
        // Skip duplicate non-terminals already printed
        int printed = 0;
        for (int k = 0; k < i; k++) {
            if (g[k][0] == nt) printed = 1;
        }
        if (printed) continue;

        printf("FOLLOW( %c ) = { ", nt);

        // Start symbol always gets '$'
        if (i == 0) printf("$ ");

        // Look for 'nt' on the RHS of all rules
        for (int r = 0; r < n; r++) {
            for (int j = 2; g[r][j] != '\0'; j++) {
                if (g[r][j] == nt) {
                    char next = g[r][j + 1];
                    // If followed by a terminal character, print it
                    if (next != '\0' && !isupper(next) && next != '#') {
                        printf("%c ", next);
                    }
                }
            }
        }
        printf("}\n");
    }

    return 0;
}