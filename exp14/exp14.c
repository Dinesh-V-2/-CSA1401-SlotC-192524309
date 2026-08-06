#include <stdio.h>
#include <ctype.h>
#include <string.h>

char opStack[100];
int opTop = -1;

char valStack[100][10];
int valTop = -1;

int tempCount = 1;

int prec(char op) {
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/') return 2;
    return 0;
}

// Generate TAC statement for top operator and top two operands
void processOp() {
    char op = opStack[opTop--];
    char op2[10], op1[10], temp[10];

    strcpy(op2, valStack[valTop--]);
    strcpy(op1, valStack[valTop--]);

    sprintf(temp, "t%d", tempCount++);
    printf("%s = %s %c %s\n", temp, op1, op, op2);

    strcpy(valStack[++valTop], temp);
}

int main() {
    char infix[100];
    printf("Enter expression (e.g., a+b*c): ");
    scanf("%s", infix);

    printf("\nThree Address Code Generation:\n");
    printf("-------------------------------\n");

    for (int i = 0; infix[i] != '\0'; i++) {
        char ch = infix[i];

        if (isalnum(ch)) {
            char str[2] = {ch, '\0'};
            strcpy(valStack[++valTop], str);
        } else if (ch == '(') {
            opStack[++opTop] = ch;
        } else if (ch == ')') {
            while (opTop != -1 && opStack[opTop] != '(') processOp();
            opTop--; // Pop '('
        } else { // Operator (+, -, *, /)
            while (opTop != -1 && prec(opStack[opTop]) >= prec(ch)) processOp();
            opStack[++opTop] = ch;
        }
    }

    while (opTop != -1) processOp();

    printf("-------------------------------\n");
    return 0;
}