/*
 CSC340 Project Phase 1
 Version 5
 */
%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylineno;
extern FILE* yyin;
extern char * yytext;
extern char * yylex();
int yyerror(char *s);
%}

%token INT DOUBLE    
%token IF ELSE THEN end
%token READ WRITE
%token REPEAT UNTIL
%token START END
%token AND OR EXCLAMATION
%token PLUS_SIGN MINUS_SIGN MULTIPLY_SIGN DIVISION_SIGN
%token EQUAL_SIGN NOTEQUAL_SIGN LESSTHAN_SIGN LESSTHANEQUAL_SIGN GREATERTHAN_SIGN GREATERTHANEQUAL_SIGN
%token ASSIGNMENT_SIGN OPENBRACKET CLOSEDBRACKET SEMICOLON
%token ID INT_LITERAL STRING_LITERAL DBL_LITERAL

%right ASSIGNMENT_SIGN
%left LESSTHANEQUAL_SIGN GREATERTHANEQUAL_SIGN EQUAL_SIGN NOTEQUAL_SIGN LESSTHAN_SIGN GREATERTHAN_SIGN
%right PLUS_SIGN MINUS_SIGN
%right MULTIPLY_SIGN DIVISION_SIGN

%%
               
Program : START stmt_sequence END
        ;


stmt_sequence : statement SEMICOLON stmt_sequencePrime
              ;
              
stmt_sequencePrime : stmt_sequence
                    | 
                    ;

statement : dec_stmt
            |if_stmt
            |repeat_stmt
            |assign_stmt
            |read_stmt
            |write_stmt
            ;

dec_stmt : type ID
         ;

type : INT
     | DOUBLE
     ;

if_stmt : IF exp THEN stmt_sequence if_stmtPrime
        ;
                
if_stmtPrime : end
              | ELSE stmt_sequence end
              ;

repeat_stmt : REPEAT stmt_sequence UNTIL exp
            ;

assign_stmt : ID ASSIGNMENT_SIGN exp // ID := exp;
            ;

read_stmt : READ ID
          ;

write_stmt : WRITE write_stmtPrime
           ;

write_stmtPrime :  OPENBRACKET exp CLOSEDBRACKET
                 | OPENBRACKET STRING_LITERAL CLOSEDBRACKET
                 ;

exp : simple_exp expPrime
    ;

expPrime : comparison_op simple_exp
         | 
         ;

comparison_op : EQUAL_SIGN //'=='
                |NOTEQUAL_SIGN // '<>'
                |LESSTHAN_SIGN // '<'
                |LESSTHANEQUAL_SIGN //'<='
                |GREATERTHAN_SIGN //'>'
                |GREATERTHANEQUAL_SIGN //'>='
                ;

simple_exp : factor simple_expPrime            
            ;
            
simple_expPrime : a_op simple_exp
                 |
                 ;                     

a_op : PLUS_SIGN // +
       |MINUS_SIGN // -
       |MULTIPLY_SIGN //*
       |DIVISION_SIGN // /
       ;

factor : OPENBRACKET exp CLOSEDBRACKET // (exp)
        | INT_LITERAL
        | DBL_LITERAL
        | ID
        ;
               
%%
    
int main(int argc, char *argv[])
{
    // don't change this part
yyin = fopen(argv[1], "r" ) ; 
if(!yyparse())
        printf("\nParsing complete\n");
    else
        printf("\nParsing failed\n");
    
    fclose(yyin);

return 0;
}

int yyerror (char *s)
{
    printf("\nsyntax error at %d \n",yylineno);
return 0;

}
