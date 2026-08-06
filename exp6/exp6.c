#include <stdio.h>
#include <ctype.h>
#include <string.h>

const char *kw[] = {"int","float","char","double","if","else","while","for","return","void"};

int isValid(char *s) {
    if (!isalpha(s[0]) && s[0] != '_') return 0; // Starts with letter or '_'
    for (int i = 1; s[i]; i++) 
        if (!isalnum(s[i]) && s[i] != '_') return 0; // Contains only alnum or '_'
    for (int i = 0; i < 10; i++) 
        if (!strcmp(s, kw[i])) return 0; // Not a reserved keyword
    return 1;
}

int main() {
    FILE *fp = fopen("input.txt", "r");
    if (!fp) return printf("Error: Cannot open input.txt\n"), 1;

    char str[50];
    printf("%-20s %s\n-----------------------------\n", "IDENTIFIER", "STATUS");

    while (fscanf(fp, "%49s", str) == 1) {
        printf("%-20s %s\n", str, isValid(str) ? "VALID" : "INVALID");
    }

    fclose(fp);
    return 0;
}