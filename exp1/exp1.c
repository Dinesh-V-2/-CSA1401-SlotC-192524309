#include <stdio.h>
#include <ctype.h>

int main()
{
    FILE *fp;
    char ch;

    fp = fopen("in.txt", "r");

    if (fp == NULL)
    {
        printf("File not found");
        return 0;
    }

    while ((ch = fgetc(fp)) != EOF)
    {
        // Ignore spaces, tabs and newlines
        if (isspace(ch))
            continue;

        // Ignore single-line comments
        if (ch == '/')
        {
            char next = fgetc(fp);
            if (next == '/')
            {
                while ((ch = fgetc(fp)) != '\n' && ch != EOF);
                continue;
            }
            else
            {
                printf("/ -> Operator\n");
                ungetc(next, fp);
                continue;
            }
        }

        // Identifier
        if (isalpha(ch))
        {
            while (isalnum(ch))
                ch = fgetc(fp);
            printf("Identifier\n");
            ungetc(ch, fp);
        }
        // Constant
        else if (isdigit(ch))
        {
            while (isdigit(ch))
                ch = fgetc(fp);
            printf("Constant\n");
            ungetc(ch, fp);
        }
        // Operators
        else if (ch=='+' || ch=='-' || ch=='*' || ch=='=')
        {
            printf("Operator\n");
        }
    }

    fclose(fp);
    return 0;
}