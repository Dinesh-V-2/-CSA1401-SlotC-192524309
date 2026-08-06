#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

int main() {
    char filename[100];
    FILE *file;
    char ch;
    
    int chars = 0, words = 0, lines = 0;
    int inWord = 0;

    printf("Enter the filename to scan: ");
    scanf("%s", filename);

    file = fopen(filename, "r");

    if (file == NULL) {
        printf("Error: Could not open file %s\n", filename);
        return 1;
    }

    while ((ch = fgetc(file)) != EOF) {
        chars++;

        // Count lines
        if (ch == '\n') {
            lines++;
        }

        // Count words (delimited by spaces, tabs, or newlines)
        if (isspace(ch)) {
            inWord = 0;
        } else if (!inWord) {
            inWord = 1;
            words++;
        }
    }

    // If the file is not empty and doesn't end with a newline, count the last line
    if (chars > 0 && ch == EOF && lines == 0) {
        lines = 1;
    }

    fclose(file);

    printf("\n--- File Scan Results ---\n");
    printf("Characters : %d\n", chars);
    printf("Words      : %d\n", words);
    printf("Lines      : %d\n", lines);
    printf("-------------------------\n");

    return 0;
}