#include <stdio.h>
#include <string.h>

struct TAC {
    char op[5];
    char arg1[10];
    char arg2[10];
    char res[10];
};

void generateAssembly(struct TAC code[], int count) {
    printf("\nTarget Machine Code (Assembly):\n");
    printf("--------------------------------\n");

    for (int i = 0; i < count; i++) {
        // Load first operand into accumulator
        printf("MOV R0, %s\n", code[i].arg1);

        // Perform arithmetic operation with second operand
        if (strcmp(code[i].op, "+") == 0) {
            printf("ADD R0, %s\n", code[i].arg2);
        } else if (strcmp(code[i].op, "-") == 0) {
            printf("SUB R0, %s\n", code[i].arg2);
        } else if (strcmp(code[i].op, "*") == 0) {
            printf("MUL R0, %s\n", code[i].arg2);
        } else if (strcmp(code[i].op, "/") == 0) {
            printf("DIV R0, %s\n", code[i].arg2);
        }

        // Store result from accumulator into destination variable
        printf("MOV %s, R0\n", code[i].res);
        printf("\n");
    }
    printf("--------------------------------\n");
}

int main() {
    int n;
    struct TAC code[10];

    printf("Enter the number of Three Address Code statements: ");
    scanf("%d", &n);

    printf("\nEnter TAC statements in format (op arg1 arg2 res):\n");
    printf("Example: + a b t1\n\n");

    for (int i = 0; i < n; i++) {
        printf("Statement %d: ", i + 1);
        scanf("%s %s %s %s", code[i].op, code[i].arg1, code[i].arg2, code[i].res);
    }

    generateAssembly(code, n);

    return 0;
}