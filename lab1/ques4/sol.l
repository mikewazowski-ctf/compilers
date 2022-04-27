%{
    #include<stdio.h>
%}

%%
.*abb.* {printf("DEAD\n");}
.* {printf("Accepted\n");}
%%

int yywrap() {return 1;}

int main(){
    yylex();
    return 0;
}
