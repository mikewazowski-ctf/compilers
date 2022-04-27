%{
	#include<stdio.h>
%}

%%
\/\/(.*) {};
\/\*(.*\n)*.*\*\/ {};
[ ]+ fprintf(yyout, "%s", " ");
[\n]+ fprintf(yyout, "%s", "\n");
[\t]+ fprintf(yyout, "%s", "\t");
. fprintf(yyout, "%s", yytext);
%%

int yywrap() {
	return 1;
}

int main() {
	extern FILE *yyin, *yyout;
	yyin = fopen("sample.c", "r");
	yyout = fopen("output.txt", "w");
	yylex();
}
