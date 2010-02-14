%{
#include <stdlib.h>
#include <iostream>
#include "XNode.h"
void yyerror(char *);
#include "o/asnx.parse.hpp"

#define STR_TOKEN(tok)      \
            strcpy(g_yy_expr_current_string, yytext); \
            count(tok); \
            return(tok);

#define TOKEN(tok)          count(tok); return(tok);
    //  Purpose:
    //      Handle maintaining debug information and returning the token.  
    //      This macro is just used as a short cut for calling count
    //      and returning.
    //  Parameters:
    //      <tok> The token.
#define MAX_LINE (1024*8)

int g_expr_scan_column = 0;
char g_expr_current_line[MAX_LINE];
char g_yy_expr_current_string[MAX_LINE];

int nline = 1;
int nchar = 1;
static void count(int token);
%}
%%

DEFINITIONS { TOKEN(DEFINITIONS) }
AUTOMATIC   { TOKEN(AUTOMATIC) }
TAGS        { TOKEN(TAGS) }
::=         { TOKEN(IS_DEFINED_AS) }
BEGIN       { TOKEN(START) }
END         { TOKEN(END) }
SEQUENCE    { TOKEN(SEQUENCE) }

[-a-zA-Z0-9]+ { STR_TOKEN(STRING) }

\n { nline++; nchar = 1;}

[ \t] ; /* skip whitespace */
[{},]        return *yytext;          

. yyerror("invalid character");

%%
int yywrap(void) {
return 1;
}


static void count(int /* token */)
{
    int i;

#ifdef DEBUG
    // printf("[%s: %d]  ", g_expr_current_line, token);
#endif
    for (i = 0; yytext[i] != '\0'; i++) {
        g_expr_current_line[g_expr_scan_column] = yytext[i];

        if (yytext[i] == '\n')
            g_expr_scan_column = 0;
        else if (yytext[i] == '\t')
            g_expr_scan_column += 8 - (g_expr_scan_column % 8);
        else
            g_expr_scan_column++;
    }
    g_expr_current_line[g_expr_scan_column] = '\0';

    // Update information to report usage errors.
// TODO
/*
    if (token != -1)
        expr::current_expr()->usage_guess(token);
*/
}


