%{
#include <stdlib.h>
#include <iostream>
void yyerror(char *);
#include "o/asnx.parse.hpp"

int nline = 1;
int nchar = 1;
%}
%%

DEFINITIONS return DEFINITIONS;
AUTOMATIC   return AUTOMATIC;
TAGS        return TAGS;
::=         return IS_DEFINED_AS;
BEGIN       return START;
END         return END;
SEQUENCE    return SEQUENCE;

[-a-zA-Z0-9]+ { return STRING; }
\n { nline++; nchar = 1;}

[ \t] ; /* skip whitespace */
[{},]        return *yytext;          

. yyerror("invalid character");

%%
int yywrap(void) {
return 1;
}




