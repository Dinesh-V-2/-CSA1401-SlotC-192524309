#include <stdio.h>
#include <string.h>

void factor(char nt, char *rule) {
    char opt[10][20], ruleCopy[100];
    int n = 0, pLen = 0;

    strcpy(ruleCopy, rule); // Keep original string safe for non-factored rules

    // 1. Split options separated by '/'
    for (char *t = strtok(ruleCopy, "/"); t; t = strtok(NULL, "/"))
        strcpy(opt[n++], t);

    // 2. Find longest common prefix among options that share a prefix
    if (n > 1) {
        while (opt[0][pLen] != '\0') {
            char c = opt[0][pLen];
            int match = 0;
            // Check if at least one other option shares this character at pLen
            for (int i = 1; i < n; i++) {
                if (opt[i][pLen] == c) match = 1;
            }
            if (!match) break;
            pLen++;
        }
    }

    // 3. If no common prefix exists, print original rule
    if (pLen == 0) { 
        printf("%c -> %s\n", nt, rule); 
        return; 
    }

    // 4. Print main production (e.g., S -> iEtSS' / a)
    printf("%c -> %.*s%c'", nt, pLen, opt[0], nt);
    for (int i = 0; i < n; i++) {
        if (strncmp(opt[i], opt[0], pLen) != 0) {
            printf(" / %s", opt[i]);
        }
    }
    printf("\n");

    // 5. Print new factored production (e.g., S' -> # / eS)
    printf("%c' -> ", nt);
    for (int i = 0, f = 1; i < n; i++) {
        if (strncmp(opt[i], opt[0], pLen) == 0) {
            if (!f) printf(" / ");
            // Print remaining suffix, or '#' for epsilon
            printf("%s", opt[i][pLen] ? opt[i] + pLen : "#");
            f = 0;
        }
    }
    printf("\n");
}

int main() {
    int n;
    char nt, rule[100];

    printf("Enter number of non-terminals: ");
    scanf("%d", &n);

    while (n--) {
        printf("\nEnter Non-Terminal: ");
        scanf(" %c", &nt);
        printf("Enter RHS productions: ");
        scanf("%s", rule);

        printf("\nResult for %c:\n", nt);
        factor(nt, rule);
    }
    return 0;
}