#include <stdio.h>
#include <string.h>

int action[7][3] =
{
    { 3,  4,  0},
    { 0,  0, 99},
    { 3,  4,  0},
    { 3,  4,  0},
    {-3, -3, -3},
    { 0,  0, -1},
    {-2, -2, -2}
};

int go[7][2] =
{
    {1, 2},
    {0, 0},
    {0, 5},
    {0, 6},
    {0, 0},
    {0, 0},
    {0, 0}
};

int column(char ch)
{
    if (ch == 'c')
        return 0;

    if (ch == 'd')
        return 1;

    if (ch == '$')
        return 2;

    return -1;
}

int main()
{
    char input[50];
    int stack[50];
    int top = 0;
    int pos = 0;
    int state, act, col;

    stack[0] = 0;

    printf("Grammar:\n");
    printf("S -> CC\n");
    printf("C -> cC | d\n\n");

    printf("Enter input string: ");
    scanf("%49s", input);

    strcat(input, "$");

    printf("\nParsing Steps:\n");

    while (1)
    {
        state = stack[top];
        col = column(input[pos]);

        if (col == -1)
        {
            printf("Invalid symbol!\n");
            return 0;
        }

        act = action[state][col];

        /* Accept */
        if (act == 99)
        {
            printf("ACCEPTED\n");
            break;
        }

        /* Shift */
        if (act > 0)
        {
            printf("Shift %c -> State %d\n",
                   input[pos], act);

            stack[++top] = act;
            pos++;
        }

        /* Reduce */
        else if (act < 0)
        {
            int rule = -act;
            int pop;

            if (rule == 1)
            {
                printf("Reduce: S -> CC\n");
                pop = 2;
            }
            else if (rule == 2)
            {
                printf("Reduce: C -> cC\n");
                pop = 2;
            }
            else
            {
                printf("Reduce: C -> d\n");
                pop = 1;
            }

            top = top - pop;

            if (rule == 1)
                stack[++top] = go[stack[top]][0];
            else
                stack[++top] = go[stack[top]][1];
        }

        /* Error */
        else
        {
            printf("REJECTED\n");
            break;
        }
    }

    return 0;
}