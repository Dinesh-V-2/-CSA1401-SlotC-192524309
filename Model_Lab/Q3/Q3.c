#include <stdio.h>
#include <ctype.h>

char str[100];
int pos = 0;

int T()
{
    int n = 0;

    while (isdigit(str[pos]))
    {
        n = n * 10 + (str[pos] - '0');
        pos++;
    }

    return n;
}

int R()
{
    if (str[pos] == '+')
    {
        pos++;
        return T() + R();
    }

    return 0;
}

int E()
{
    int t = T();
    return t + R();
}

int main()
{
    printf("Enter expression: ");
    scanf("%s", str);

    printf("Expression = %s\n", str);
    printf("Result = %d\n", E());

    return 0;
}