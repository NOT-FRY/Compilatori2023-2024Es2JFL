/*Import*/

import java_cup.runtime.*;
import srcjflexcup/Token;

%%

%class Lexer
%unicode
%line
%column
%cupsym Token
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


Identifier = [A-Za-z] ( [A-Za-z_] | [0-9] )*

IntegerNumber = 0 | [1-9][0-9]*
FloatingNumber = IntegerNumber.[0-9]+


%state STRING

%%

/* keywords */
<YYINITIAL> "if"              { return symbol(Token.IF); }
<YYINITIAL> "then"            { return symbol(Token.THEN); }
<YYINITIAL> "else"            { return symbol(Token.ELSE); }
<YYINITIAL> "while"            { return symbol(Token.WHILE); }
<YYINITIAL> "int"            { return symbol(Token.INT); }
<YYINITIAL> "float"            { return symbol(Token.FLOAT); }


/*Whitespaces*/
<YYINITIAL> {WhiteSpace}      { /*ignora*/ }


/*Identificatori e Literals*/
<YYINITIAL>{
    {Identifier}            { return symbol(Token.ID); }

    {IntegerNumber}         {return symbol(Token.INUMBER);}

    {FloatingNumber}        {return symbol(Token.FNUMBER);}

}

/*Separatori*/
<YYINITIAL>{
    "("           { return symbol(Token.LPAR); }
    ")"           { return symbol(Token.RPAR); }
    "{"           { return symbol(Token.LCUR); }
    "}"           { return symbol(Token.RCUR); }
    ","           { return symbol(Token.COM); }
    ";"           { return symbol(Token.SEMI); }
}

/*Operatori*/
<YYINITIAL>{
    "<--"           { return symbol(Token.ASS); }
    "<"           { return symbol(Token.LT); }
    "<="           { return symbol(Token.LE); }
    ">"           { return symbol(Token.GT); }
    ">="           { return symbol(Token.GE); }
    "="           { return symbol(Token.EQ); }
    "!="           { return symbol(Token.NE); }
    "+"           { return symbol(Token.ADD); }
    "-"           { return symbol(Token.MIN); }
    "*"           { return symbol(Token.MUL); }
    "/"           { return symbol(Token.DIV); }
}

/*Commenti*/
<YYINITIAL> {Comment}      { /*ignora*/ }

/*String literals*/
\"                  { string.setLength(0); yybegin(STRING); }

<STRING> {
    \"              {
                        yybegin(YYINITIAL);
                        return symbol(Token.STRING_LITERAL,
                        string.toString());
                    }
    [^\n\r\"\\]+    { string.append( yytext() ); }
    \\t             { string.append('\t'); }
    \\n             { string.append('\n'); }
    \\r             { string.append('\r'); }
    \\\" { string.append('\"'); }
    \\ { string.append('\\'); }
}


/* error fallback */

[^]                {return symbol(Token.ERROR,"-Carattere non consentito<"+
                    yytext()+"> a riga "+yyline()+"\n" );}
