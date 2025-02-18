%{
/* Declaraciones en C */
#include <stdio.h>
int linea = 1;
%}

/* Definiciones */
DIGITO      [0-9]
LETRA       [a-zA-ZáéíóúÁÉÍÓÚñÑ]
ESPACIO     [ \t]
SALTOLINEA  \n

%%
{ESPACIO}+                  ; /* Ignorar espacios */
{SALTOLINEA}               { linea++; }

"//"[^\n]*                 { printf("COMENTARIO: %s\n", yytext); }
"/*"([^*]|\*+[^*/])*"*/"  { printf("COMENTARIO: %s\n", yytext); }

"if"|"else"|"int"|"float"|"string"|"while"|"return"|"true"|"false"    { printf("PALABRA_CLAVE: %s\n", yytext); }

{LETRA}({LETRA}|{DIGITO}|_)*    { printf("IDENTIFICADOR: %s\n", yytext); }

-?{DIGITO}*\.{DIGITO}+|-?{DIGITO}+\.    { printf("NUMERO_FLOAT: %s\n", yytext); }
-?{DIGITO}+                { printf("NUMERO: %s\n", yytext); }

\"([^\"]|\\.)*\"          { printf("LITERAL_CADENA: %s\n", yytext); }

"&&"|"||"                 { printf("OPERADOR_LOGICO: %s\n", yytext); }
"!=="|"==="|"=="|"!="|">="|"<="|">"|"<"    { printf("OPERADOR_COMPARACION: %s\n", yytext); }
[+\-*/=!]                 { printf("OPERADOR: %s\n", yytext); }
[;{}():]                  { printf("DELIMITADOR: %s\n", yytext); }

.                         { printf("Error léxico en línea %d: Carácter no reconocido '%s'\n", linea, yytext); }

%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}