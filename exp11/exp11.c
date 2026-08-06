#include <stdio.h>
#include <string.h>

struct Symbol {
    char name[10];
    char type[10];
    int addr;
} sym[10];

int count = 0;
n
void insert() {
    printf("Enter Name, Type, Address: ");
    scanf("%s %s %d", sym[count].name, sym[count].type, &sym[count].addr);
    count++;
    printf("Inserted successfully!\n");
}

void display() {
    printf("\nNAME\tTYPE\tADDRESS\n");
    for (int i = 0; i < count; i++) {
        printf("%s\t%s\t%d\n", sym[i].name, sym[i].type, sym[i].addr);
    }
}

void search() {
    char name[10];
    printf("Enter Name to search: ");
    scanf("%s", name);
    for (int i = 0; i < count; i++) {
        if (strcmp(sym[i].name, name) == 0) {
            printf("Found at Address: %d\n", sym[i].addr);
            return;
        }
    }
    printf("Not Found!\n");
}

int main() {
    int ch;
    while (1) {
        printf("\n1.Insert  2.Display  3.Search  4.Exit\nChoice: ");
        scanf("%d", &ch);
        if (ch == 1) insert();
        else if (ch == 2) display();
        else if (ch == 3) search();
        else break;
    }
    return 0;
}