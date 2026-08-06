#include <stdio.h>
#include <ctype.h>

int main() {
    FILE *fp = fopen("input.txt", "r");
    if (!fp) return printf("Error opening file!\n"), 1;

    char c;
    while ((c = fgetc(fp)) != EOF) {
        if (isspace(c)) continue; // 1. Skip spaces, tabs, newlines

        // 2. Handle Comments & Division Operator
        if (c == '/') {
            char n = fgetc(fp);
            if (n == '/') { while ((c = fgetc(fp)) != EOF && c != '\n'); continue; }
            if (n == '*') { while ((c = fgetc(fp)) != EOF && !(c == '*' && fgetc(fp) == '/')); continue; }
            if (n != EOF) ungetc(n, fp);
            printf("Operator  : /\n");
        }
        // 3. Identifiers / Keywords
        else if (isalpha(c) || c == '_') {
            char word[31]; int len = 0; word[len++] = c;
            while ((c = fgetc(fp)) != EOF && (isalnum(c) || c == '_')) if (len < 30) word[len++] = c;
            word[len] = '\0';
            if (c != EOF) ungetc(c, fp);
            printf("Identifier: %s\n", word);
        }
        // 4. Constants
        else if (isdigit(c)) {
            char num[31]; int len = 0; num[len++] = c;
            while ((c = fgetc(fp)) != EOF && (isdigit(c) || c == '.')) if (len < 30) num[len++] = c;
            num[len] = '\0';
            if (c != EOF) ungetc(c, fp);
            printf("Constant  : %s\n", num);
        }
        // 5. Operators
        else if (c == '+' || c == '-' || c == '*' || c == '=') {
            printf("Operator  : %c\n", c);
        }
    }

    fclose(fp);
    return 0;
}