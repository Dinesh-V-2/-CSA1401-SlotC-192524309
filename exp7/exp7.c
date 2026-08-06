#include <stdio.h>
#include <ctype.h>

char gram[4][10] = {"S=AaAb", "S=BbBa", "A=#", "B=#"};

void findFirst(char symbol) {
    if (!isupper(symbol)) { printf("%c ", symbol); return; }

    for (int i = 0; i < 4; i++) {
        if (gram[i][0] == symbol) {
            int j = 2;
            while (gram[i][j]) {
                if (!isupper(gram[i][j]) || gram[i][j] == '#') {
                    printf("%c ", gram[i][j]);
                    break; // Stop if terminal or '#' found
                }
                j++; // Advance past nullable non-terminals (A -> #)
            }
        }
    }
}

int main() {
    char nonTerminals[] = {'S', 'A', 'B'};
    for (int i = 0; i < 3; i++) {
        printf("FIRST( %c ) = { ", nonTerminals[i]);
        findFirst(nonTerminals[i]);
        printf("}\n");
    }
    return 0;
}