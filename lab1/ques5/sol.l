%{
    #include<stdio.h>
%}

%%
"float" {fprintf(yyout, "double");}
. {fprintf(yyout, "%s", yytext);}
%%

int yywrap() {return 1;}

int main(){

    extern FILE *yyin, *yyout;
    yyin = fopen("sample.c", "r");
    yyout = fopen("output.txt", "w");

    yylex();

    return 0;
}
