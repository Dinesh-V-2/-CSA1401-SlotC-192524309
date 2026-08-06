#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

const char *s;
int error = 0;

void E(), E_prime(), T(), T_prime(), F();

void match(char expected) {
    if (*s == expected) s++;
    else error = 1;
}

void E() {
    T();
    E_prime();
}

void E_prime() {
    if (*s == '+') {
        s++;
        T();
        E_prime();
    }
}

void T() {
    F();
    T_prime();
}

void T_prime() {
    if (*s == '*') {
        s++;
        F();
        T_prime();
    }
}

void F() {
    if (*s == '(') {
        s++;
        E();
        match(')');
    } else if (isalnum(*s)) { // Matches 'id' (single alphanumeric character)
        while (isalnum(*s)) s++;
    } else {
        error = 1;
    }
}

int main() {
    char input[100];
    printf("Enter string: ");
    scanf("%s", input);
    s = input;

    E();

    if (!error && *s == '\0')
        printf("Parsing Successful! String is VALID.\n");
    else
        printf("Parsing Failed! String is INVALID.\n");

    return 0;
}