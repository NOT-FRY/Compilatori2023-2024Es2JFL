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
%standalone

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
\"                    { string.setLength(0); yybegin(STRING); }

<STRING> {
    \"              {
                        yybegin(YYINITIAL);
                        return symbol(jflex.generated.Token.STRING_LITERAL,
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

[^]                {return symbol(jflex.generated.Token.ERROR,"-Carattere non consentito<"+
                    yytext()+"> a riga "+yyline+"\n" );}
