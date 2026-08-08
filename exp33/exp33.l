%{
#include <stdio.h>
%}

PROTOCOL    (http|https|ftp):\/\/
WWW         (www\.)?
DOMAIN      [a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+
IP          ([0-9]{1,3}\.){3}[0-9]{1,3}
PORT        (:[0-9]{1,5})?
PATH        (\/[a-zA-Z0-9_%\=\?&\.\-]*)*\/?

%%

{PROTOCOL}{WWW}({DOMAIN}|{IP}){PORT}{PATH}  { printf("VALID URL: %s\n", yytext); }
[^\n]+                                       { printf("INVALID URL: %s\n", yytext); }
\n                                           ;

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter URL to validate:\n");
    yylex();
    return 0;
}