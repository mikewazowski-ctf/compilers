%{
    #include<stdio.h>
    #include "yaccprog.tab.h"
    extern int yylval;
%}




/* Rule Section */
%%
[0-9]+ {yylval=atoi(yytext);return NUMBER;}
[a-zA-Z_][a-zA-Z0-9_]* {yylval = yytext;return IDENTIFIER;}
"&&" {yylval = yytext;return AND;}
"||" {yylval = yytext;return OR;}
"==" {yylval = yytext;return EQUAL_TO;}
"!=" {yylval = yytext;return NOT_EQUAL_TO;}
">"  {yylval = yytext;return GREATER_THAN;}
"<"  {yylval = yytext;return LESSER_THAN;}
">=" {yylval = yytext;return GREATER_THAN_EQUAL_TO;}
"<=" {yylval = yytext;return LESSER_THAN_EQUAL_TO;}
[\t] ;
[\n] return 0;   
. return yytext[0];
%%

int yywrap(){
    return 1;
}
