/*Import*/

package jflex.generated;
import java_cup.runtime.*;

%%

%class Lexer
%unicode
%line
%column
%cupsym jflex.generated.Token
%cup

%{
    StringBuffer string = new StringBuffer();
        private Symbol symbol(int type) {
            return new Symbol(type, yyline, yycolumn);
        }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

/*Whitespaces*/
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]

/*Comments*/
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"

// Comment can be the last line of the file, without line terminator.
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent = ( [^*] | \*+ [^/*] )*

WHITE_SPACE_CHAR=[\n\r\ \t\b\012]
STRING_TEXT=(\\\"|[^\n\r\"\\]|\\{WHITE_SPACE_CHAR}+\\)*


Identifier = [A-Za-z] ( [A-Za-z_] | [0-9] )*

IntegerNumber = 0 | [1-9][0-9]*
FloatingNumber = {IntegerNumber}"."[0-9]+


%state STRING

%%

/* keywords */
<YYINITIAL> "if"              { return symbol(jflex.generated.Token.IF); }
<YYINITIAL> "then"            { return symbol(jflex.generated.Token.THEN); }
<YYINITIAL> "else"            { return symbol(jflex.generated.Token.ELSE); }
<YYINITIAL> "while"            { return symbol(jflex.generated.Token.WHILE); }
<YYINITIAL> "int"            { return symbol(jflex.generated.Token.INT); }
<YYINITIAL> "float"            { return symbol(jflex.generated.Token.FLOAT); }


/*Whitespaces*/
<YYINITIAL> {WhiteSpace}      { /*ignora*/ }


/*Identificatori e Literals*/
<YYINITIAL>{
    {Identifier}            { return symbol(jflex.generated.Token.ID); }

    {IntegerNumber}         {return symbol(jflex.generated.Token.INUMBER);}

    {FloatingNumber}        {return symbol(jflex.generated.Token.FNUMBER);}

}

/*Separatori*/
<YYINITIAL>{
    "("           { return symbol(jflex.generated.Token.LPAR); }
    ")"           { return symbol(jflex.generated.Token.RPAR); }
    "{"           { return symbol(jflex.generated.Token.LCUR); }
    "}"           { return symbol(jflex.generated.Token.RCUR); }
    ","           { return symbol(jflex.generated.Token.COM); }
    ";"           { return symbol(jflex.generated.Token.SEMI); }
}

/*Operatori*/
<YYINITIAL>{
    "<--"           { return symbol(jflex.generated.Token.ASS); }
    "<"           { return symbol(jflex.generated.Token.LT); }
    "<="           { return symbol(jflex.generated.Token.LE); }
    ">"           { return symbol(jflex.generated.Token.GT); }
    ">="           { return symbol(jflex.generated.Token.GE); }
    "="           { return symbol(jflex.generated.Token.EQ); }
    "!="           { return symbol(jflex.generated.Token.NE); }
    "+"           { return symbol(jflex.generated.Token.ADD); }
    "-"           { return symbol(jflex.generated.Token.MIN); }
    "*"           { return symbol(jflex.generated.Token.MUL); }
    "/"           { return symbol(jflex.generated.Token.DIV); }
}

/*Commenti*/
<YYINITIAL> {Comment}      { /*ignora*/ }



/*String literals*/

  \"{STRING_TEXT}\" {
    String str =  yytext().substring(1,yylength()-1);
    return symbol(jflex.generated.Token.STRING_LITERAL,str);
  }


/* error fallback */

[^]                {return symbol(jflex.generated.Token.ERROR,"-Carattere non consentito<"+
                    yytext()+"> a riga "+yyline+"\n" );}
