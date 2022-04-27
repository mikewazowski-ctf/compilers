%{
    #include<stdio.h>
    #include<string.h>
%}

%%
[+]+ {ECHO; if(strlen((const char*)yytext) == 2){
                printf(":Increment operator\n");
            }
            else{
                printf(":Addition operator\n");
            }
    }
[-]+ {ECHO; if(strlen((const char*)yytext) == 2){
                printf(":Decrement operator\n");
            }
            else{
                printf(":Subtraction operator\n");
            }
    }
[*] {ECHO; printf(":Multiplication operator\n");}
[/] {ECHO; printf(":Division operator\n");}
[&]+ {ECHO; if(strlen((const char*)yytext) == 2){
                printf(":Logical AND operator\n");
            }
            else{
                printf(":Bitwise AND operator\n");
            }
    }
[|]+ {ECHO; if(strlen((const char*)yytext) == 2){
                printf(":Logical OR operator\n");
            }
            else{
                printf(":Bitwise OR operator\n");
            }
    }
[!] {ECHO; printf(":Logical negation operator\n");}
[~] {ECHO; printf(":Bitwise negation operator\n");}
[%] {ECHO; printf(":Modulo operator\n");}
[=]+ {ECHO; if(strlen((const char*)yytext) == 2){
                printf(":Equality operator\n");
            }
            else{
                printf(":Assignment operator\n");
            }
    }
[>][=]? {ECHO; if(strlen((const char*)yytext) == 2){
                printf(":Greater than or equal to operator\n");
            }
            else{
                printf(":Greater than operator\n");
            }
    }

[<][=]? {ECHO; if(strlen((const char*)yytext) == 2){
                printf(":Lesser than or equal to operator\n");
            }
            else{
                printf(":Lesser than operator\n");
            }
    }
. ;
%%

int yywrap() {return 1;}

int main(){
    yylex();
    return 0;
}
