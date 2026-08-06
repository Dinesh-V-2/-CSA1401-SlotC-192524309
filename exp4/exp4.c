#include <stdio.h>

int main() {
    FILE *fp = fopen("input.txt", "r");
    if (!fp) fp = stdin; // Fallback to standard input if file doesn't exist
    char c;

    while ((c = fgetc(fp)) != EOF) {
        if (c == '/') {
            char n = fgetc(fp);
            if (n == '/') { while ((c = fgetc(fp)) != EOF && c != '\n'); continue; }
            if (n == '*') { while ((c = fgetc(fp)) != EOF && !(c == '*' && fgetc(fp) == '/')); continue; }
            if (n != EOF) ungetc(n, fp);
            printf("VALID ARITHMETIC OPERATOR: /\n");
        } 
        else if (c == '+' || c == '-' || c == '*') {
            printf("VALID ARITHMETIC OPERATOR: %c\n", c);
        }
    }
    if (fp != stdin) fclose(fp);
    return 0;
}