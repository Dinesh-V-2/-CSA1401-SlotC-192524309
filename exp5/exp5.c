#include <stdio.h>

int main() {
    FILE *fp = fopen("input.txt", "r");
    if (!fp) return 1;

    char c;
    int spaces = 0, newlines = 0;

    while ((c = fgetc(fp)) != EOF) {
        if (c == ' ' || c == '\t') spaces++;
        else if (c == '\n') newlines++;
    }

    fclose(fp);
    printf("Whitespaces (Spaces/Tabs) : %d\nNewlines                  : %d\n", spaces, newlines);
    return 0;
}