%{
	#include<stdio.h>
	int answer=0;
%}

%token NUMBER
%token IDENTIFIER
%token AND OR
%token EQUAL_TO NOT_EQUAL_TO
%token GREATER_THAN LESSER_THAN
%token GREATER_THAN_EQUAL_TO LESSER_THAN_EQUAL_TO
%left OR
%left AND
%left '|'
%left '^'
%left '&'
%left EQUAL_TO NOT_EQUAL_TO
%left GREATER_THAN LESSER_THAN GREATER_THAN_EQUAL_TO LESSER_THAN_EQUAL_TO
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'
/* Rule Section */
%%

    Expression: E {return 0;}

    E:E'+'E

    |E'-'E

    |E'*'E

    |E'/'E

    |E'%'E

    |E OR E

    |E AND E

    |E GREATER_THAN_EQUAL_TO E

    |E LESSER_THAN_EQUAL_TO E

    |E GREATER_THAN E

    |E LESSER_THAN E

    |E EQUAL_TO E

    |E NOT_EQUAL_TO E

    |'('E')'

    | NUMBER

    | IDENTIFIER

    ;

%%

//driver code
void main(){
	printf("\nEnter Any Expression: Arithmetic, Boolean or Relational\n");
	yyparse();
	if(answer==0)
		printf("\nEntered expression is Valid\n\n");
}


void yyerror(){
	printf("\nEntered expression is Invalid\n\n");
	answer=1;
}
