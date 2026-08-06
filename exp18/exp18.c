#include <stdio.h>
#include <ctype.h>
#include <string.h>
char p[10][10], T[128][128] = {0}, N[] = "ETF", terms[] = "+*)i";
int n, c = 1, i, t;
int main() {
    printf("Enter number of rules: ");
    scanf("%d", &n);
    printf("Enter rules (e.g. E->E+T, F->i for id):\n");
    for (i = 0; i < n; i++) scanf("%s", p[i]);
    for (i = 0; i < n; i++) {
        char A = p[i][0];
        int len = strlen(p[i]);
        char last = p[i][len - 1];
        char prev = (len > 4) ? p[i][len - 2] : '\0';

        if (!isupper(last)) T[A][last] = 1;
        else if (prev && !isupper(prev)) T[A][prev] = 1;
    }
    while (c--) 
        for (i = 0; i < n; i++) {
            char A = p[i][0];
            char last = p[i][strlen(p[i]) - 1];
            if (isupper(last))
                for (t = 0; t < 4; t++)
                    if (T[last][terms[t]] && !T[A][terms[t]])
                        T[A][terms[t]] = c = 1;
        }
    printf("\n--- TRAILING Sets ---\n");
    for (i = 0; i < 3; i++) {
        printf("TRAILING(%c) = { ", N[i]);
        for (t = 0; t < 4; t++) 
            if (T[N[i]][terms[t]]) printf(terms[t] == 'i' ? "id " : "%c ", terms[t]);
        printf("}\n");
    }
}