#include <stdio.h>
#include <ctype.h>
#include <string.h>

const char *kw[] = {"int","float","if","else","while","for","return","void"};

int main() {
    FILE *fp = fopen("input.txt", "r");
    if (!fp) return 1;
    char c;

    while ((c = fgetc(fp)) != EOF) {
        if (isspace(c)) continue;

        // Skip comments / process '/'
        if (c == '/') {
            char n = fgetc(fp);
            if (n == '/') { while ((c = fgetc(fp)) != EOF && c != '\n'); continue; }
            if (n == '*') { while ((c = fgetc(fp)) != EOF && !(c == '*' && fgetc(fp) == '/')); continue; }
            if (n != EOF) ungetc(n, fp);
            printf("OPERATOR  : /\n"); continue;
        }

        // Keywords & Identifiers (Max 30 chars)
        if (isalpha(c) || c == '_') {
            char b[31]; int l = 0; b[l++] = c;
            while ((c = fgetc(fp)) != EOF && (isalnum(c) || c == '_')) if (l < 30) b[l++] = c;
            b[l] = '\0';
            if (c != EOF) ungetc(c, fp);
            
            int is_k = 0;
            for (int i = 0; i < 8; i++) if (!strcmp(b, kw[i])) is_k = 1;
            printf("%-10s: %s\n", is_k ? "KEYWORD" : "IDENTIFIER", b);
        }
        // Constants
        else if (isdigit(c)) {
            char b[31]; int l = 0; b[l++] = c;
            while ((c = fgetc(fp)) != EOF && (isdigit(c) || c == '.')) if (l < 30) b[l++] = c;
            b[l] = '\0';
            if (c != EOF) ungetc(c, fp);
            printf("CONSTANT  : %s\n", b);
        }
        // Operators
        else if (strchr("+-*%=><!&|^", c)) {
            char op[3] = {c, '\0', '\0'}, n = fgetc(fp);
            if (strchr("+-*%=><!&|^", n)) op[1] = n;
            else if (n != EOF) ungetc(n, fp);
            printf("OPERATOR  : %s\n", op);
        }
        // Special Symbols
        else printf("SYMBOL    : %c\n", c);
    }
    fclose(fp);
    return 0;
}