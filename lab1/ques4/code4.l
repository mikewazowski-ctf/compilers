%{
    #include<stdio.h>
%}

%s STATE1 STATE2 DEAD

%%
<INITIAL>a BEGIN STATE1;
<INITIAL>b BEGIN INITIAL;
<INITIAL>[^ab\n] BEGIN DEAD;
<INITIAL>\n BEGIN INITIAL; {printf("Accepted\n");}

<STATE1>b BEGIN STATE2;
<STATE1>a BEGIN STATE1;
<STATE1>[^ab\n] BEGIN DEAD;
<STATE1>\n BEGIN INITIAL; {printf("Accepted\n");}

<STATE2>b BEGIN DEAD;
<STATE2>a BEGIN STATE1;
<STATE2>[^ab\n] BEGIN DEAD;
<STATE2>\n BEGIN INITIAL; {printf("Accepted\n");}

<DEAD>[^\n] BEGIN DEAD;
<DEAD>\n BEGIN INITIAL; {printf("Not Accepted\n");}
%%

int yywrap() {return 1;}

int main(){
    yylex();
    return 0;
}