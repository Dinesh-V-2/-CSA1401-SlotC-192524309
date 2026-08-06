#include <stdio.h>
#include <ctype.h>

char p[10][10], L[128][128] = {0}, N[] = "ETF", T[] = "+*(i";
int n, c = 1, i, t;

int main() {
    printf("Enter number of rules: ");
    scanf("%d", &n);
    printf("Enter rules (e.g. E->E+T, F->i for id):\n");
    for (i = 0; i < n; i++) scanf("%s", p[i]);

    // Step 1: Direct terminals (A -> a... or A -> B a...)
    for (i = 0; i < n; i++) {
        char A = p[i][0], *r = p[i] + 3;
        if (!isupper(r[0])) L[A][r[0]] = 1;
        else if (!isupper(r[1]) && r[1]) L[A][r[1]] = 1;
    }

    // Step 2: Propagate non-terminal LEADING sets (A -> B...)
    while (c--) 
        for (i = 0; i < n; i++)
            if (isupper(p[i][3]))
                for (t = 0; t < 4; t++)
                    if (L[p[i][3]][T[t]] && !L[p[i][0]][T[t]])
                        L[p[i][0]][T[t]] = c = 1;

    // Output
    for (i = 0; i < 3; i++) {
        printf("LEADING(%c) = { ", N[i]);
        for (t = 0; t < 4; t++) 
            if (L[N[i]][T[t]]) printf(T[t] == 'i' ? "id " : "%c ", T[t]);
        printf("}\n");
    }
}