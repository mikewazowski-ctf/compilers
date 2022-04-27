%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    
    struct symbtab {
        char identifiers[1000][32];
        char datatype[1000][32];
        int max_offset;
    };
    int scope=0, max_scope=0;
    struct symbtab SYMBTABS[10];
    char last_keywork[32];

    int SizeFunc(char* s)
    {
        if(strcmp(s, "int")==0) return 4;
        if(strcmp(s, "char")==0) return 1;
        if(strcmp(s, "float")==0) return 4;
        if(strcmp(s, "double")==0) return 8;
        if(strcmp(s, "long")==0) return 4;
        return 0;
    }
    
%}

%x ML_COMMENT

KEYWORD_AUTO	    auto
KEYWORD_DOUBLE	    double
KEYWORD_INT	        int
KEYWORD_STRUCT	    struct
KEYWORD_BREAK	    break
KEYWORD_ELSE	    else
KEYWORD_LONG	    long
KEYWORD_SWITCH	    switch
KEYWORD_CASE	    case
KEYWORD_ENUM	    enum
KEYWORD_REGISTER	register
KEYWORD_TYPEDEF	    typedef
KEYWORD_CHAR	    char
KEYWORD_EXTERN	    extern
KEYWORD_RETURN	    return
KEYWORD_UNION	    union
KEYWORD_CONTINUE	continue
KEYWORD_FOR	        for
KEYWORD_SIGNED	    signed
KEYWORD_VOID	    void
KEYWORD_DO	        do
KEYWORD_IF	        if
KEYWORD_STATIC	    static
KEYWORD_WHILE	    while
KEYWORD_DEFAULT	    default
KEYWORD_GOTO	    goto
KEYWORD_SIZEOF	    sizeof
KEYWORD_VOLATILE	volatile
KEYWORD_CONST	    const
KEYWORD_FLOAT	    float
KEYWORD_SHORT	    short
KEYWORD_UNSIGNED	unsigned

INT             \-?[0-9]{1,9}
FLOAT           \-?[0-9]{1,38}\.[0-9]{1,6}
DOUBLE          \-?[0-9]{1,308}\.[0-9]{1,15}
LONG            \-?[0-9]{1,18}
LONGDOUBLE      \-?[0-9]{1,4932}\.[0-9]{1,19}

ID              [_a-zA-Z][_a-zA-Z0-9]{0,31}
NUM             {INT}|{FLOAT}|{DOUBLE}|{LONG}|{LONGDOUBLE}
DATA_KEYWORDS   {KEYWORD_INT}|{KEYWORD_CHAR}|{KEYWORD_FLOAT}|{KEYWORD_LONG}|{KEYWORD_DOUBLE}
KEYWORDS        {KEYWORD_AUTO}|{KEYWORD_DOUBLE}|{KEYWORD_INT}|{KEYWORD_STRUCT}|{KEYWORD_BREAK}|{KEYWORD_ELSE}|{KEYWORD_LONG}|{KEYWORD_SWITCH}|{KEYWORD_CASE}|{KEYWORD_ENUM}|{KEYWORD_REGISTER}|{KEYWORD_TYPEDEF}|{KEYWORD_CHAR}|{KEYWORD_EXTERN}|{KEYWORD_RETURN}|{KEYWORD_UNION}|{KEYWORD_CONTINUE}|{KEYWORD_FOR}|{KEYWORD_SIGNED}|{KEYWORD_VOID}|{KEYWORD_DO}|{KEYWORD_IF}|{KEYWORD_STATIC}|{KEYWORD_WHILE}|{KEYWORD_DEFAULT}|{KEYWORD_GOTO}|{KEYWORD_SIZEOF}|{KEYWORD_VOLATILE}|{KEYWORD_CONST}|{KEYWORD_FLOAT}|{KEYWORD_SHORT}|{KEYWORD_UNSIGNED}
PUNCT           [\;\:\'\"\,]
%%

\/\/.*\n        {printf("");}
\/\*(.|\n)*\*\/ {printf("");}

\#define.*\n    {printf("");}
\#include<[a-z]+[\.h]?> {printf("");}
\#.*\n          {printf("");}

\{              {scope = scope + 1;}
\}              {
                if(scope>max_scope) max_scope = scope;
                scope = scope-1;
                }
{DATA_KEYWORDS} {strcpy(last_keywork, yytext);}
{KEYWORDS}      {printf("%s--KEYWORD\n", yytext);}
{NUM}           {printf("%s--NUMERIC_DATA\n", yytext);}
[0-9][_a-zA-Z0-9]*  {printf("%s--id should not begin with number\n", yytext);}
[_a-zA-Z][_a-zA-Z0-9]{31}+  {printf("%s--length of identifier is too high\n", yytext);}

{ID}            {printf("%s--IDENTIFIER\n", yytext);
                int* x = &SYMBTABS[scope].max_offset;
                strcpy(SYMBTABS[scope].identifiers[*x+1], yytext);
                strcpy(SYMBTABS[scope].datatype[*x+1], last_keywork);
                *x = *x + 1;}
.               {printf("");}
\n              {printf("");}
%%


int yywrap(void){return 1;}

int main()
{
    int i=0, j=0;
    for(i=0; i<10;i++)
    {
        SYMBTABS[i].max_offset = 0;
    }

    extern FILE *yyin, *yyout;
	yyin = fopen("input.c", "r");
    yylex();
    fclose(yyin);
    printf("\nidentifier\tdatatype\tsize\tscope\toffset\n");
    printf("---------------------------------------------------\n");
    for(i=0; i<=max_scope; i++)
    {
        int Offset = 0;
        for(j=1; j<SYMBTABS[i].max_offset; j++)
        {
            
            int tempp=SizeFunc(SYMBTABS[i].datatype[j]);
            Offset += tempp;
            printf("%s\t\t%s\t\t%d\t%d\t%d\n",SYMBTABS[i].identifiers[j], SYMBTABS[i].datatype[j], tempp, i, Offset);
        }
    }
    return 0;
}
