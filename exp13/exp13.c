#include <stdio.h>
#include <string.h>
#include <ctype.h>

char stack[100];
int top = -1;

void push(char c) {
    stack[++top] = c;
    stack[top + 1] = '\0';
}

void pop(int count) {
    top -= count;
    stack[top + 1] = '\0';
}

// Function to perform reduce operations
int reduce() {
    // Rule: E -> ( E )
    if (top >= 2 && stack[top - 2] == '(' && stack[top - 1] == 'E' && stack[top] == ')') {
        pop(3);
        push('E');
        return 1;
    }
    // Rule: E -> E + E
    if (top >= 2 && stack[top - 2] == 'E' && stack[top - 1] == '+' && stack[top] == 'E') {
        pop(3);
        push('E');
        return 1;
    }
    // Rule: E -> E * E
    if (top >= 2 && stack[top - 2] == 'E' && stack[top - 1] == '*' && stack[top] == 'E') {
        pop(3);
        push('E');
        return 1;
    }
    // Rule: E -> id (alphanumeric character except 'E')
    if (top >= 0 && isalnum(stack[top]) && stack[top] != 'E') {
        pop(1);
        push('E');
        return 1;
    }
    return 0; // No reduction possible
}

int main() {
    char input[100];
    int i = 0;

    printf("Enter string: ");
    scanf("%s", input);

    printf("\n%-15s %-15s %-15s\n", "Stack", "Input Buffer", "Action");
    printf("---------------------------------------------\n");

    while (input[i] != '\0') {
        // Shift operation
        push(input[i]);
        i++;
        printf("%-15s %-15s Shift\n", stack, &input[i]);

        // Attempt reductions repeatedly after each shift
        while (reduce()) {
            printf("%-15s %-15s Reduce to E\n", stack, &input[i]);
        }
    }

    // Final validation check
    if (top == 0 && stack[0] == 'E') {
        printf("---------------------------------------------\n");
        printf("Result: Parsing Successful! String is VALID.\n");
    } else {
        printf("---------------------------------------------\n");
        printf("Result: Parsing Failed! String is INVALID.\n");
    }

    return 0;
}