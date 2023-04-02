/*
 CSC340 Project Phase 1
 Version 5
 */
%{

#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

void yyerror ();
%}

%option yylineno
%s COMMENT


%%
<INITIAL>"@"         {BEGIN COMMENT;}
<COMMENT>"@"         {BEGIN INITIAL;}
<COMMENT>.           ;
<COMMENT>[\n]        ;
<INITIAL>"int"       {return INT;}
<INITIAL>"double"    {return DOUBLE;}
<INITIAL>"if"        {return IF;}
<INITIAL>"else"      {return ELSE;}
<INITIAL>"then"      {return THEN;}
<INITIAL>"end"       {return end;}
<INITIAL>"read"      {return READ;}
<INITIAL>"write"     {return WRITE;}
<INITIAL>"repeat"    {return REPEAT;}
<INITIAL>"until"     {return UNTIL;}
<INITIAL>"START"     {return START;}
<INITIAL>"END"       {return END;}


<INITIAL>"+"         {return PLUS_SIGN;}
<INITIAL>"-"         {return MINUS_SIGN;}
<INITIAL>"*"         {return MULTIPLY_SIGN;}
<INITIAL>"/"         {return DIVISION_SIGN;}

<INITIAL>"&"         {return AND;}
<INITIAL>"|"         {return OR;}
<INITIAL>"!"         {return EXCLAMATION;}

<INITIAL>"=="        {return EQUAL_SIGN;}
<INITIAL>"<>"        {return NOTEQUAL_SIGN;}
<INITIAL>"<"         {return LESSTHAN_SIGN;}
<INITIAL>"<="        {return LESSTHANEQUAL_SIGN;}
<INITIAL>">"         {return GREATERTHAN_SIGN;}
<INITIAL>">="        {return GREATERTHANEQUAL_SIGN;}

<INITIAL>":="        {return ASSIGNMENT_SIGN;}

<INITIAL>"("         {return OPENBRACKET;}
<INITIAL>")"         {return CLOSEDBRACKET;}
<INITIAL>";"         {return SEMICOLON;}

<INITIAL>[A-Z][A-Za-z0-9_]*      {return ID;}
<INITIAL>[0-9]+                  {return INT_LITERAL;}
<INITIAL>[0-9]+\.[0-9]+          {return DBL_LITERAL;}
<INITIAL>[\"][.*\n]+[\"]       {return STRING_LITERAL;}
<INITIAL>[ ]                    ;
<INITIAL>[\n]                   ;
%%

int yywrap(){
return 1;
}
