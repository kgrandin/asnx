%{
#include <stdlib.h>
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

\n { nline++; nchar = 1;}


[-a-zA-Z0-9]+ { return STRING; }


[ \t] ; /* skip whitespace */

%%
int yywrap(void) {
return 1;
}




