/*Import*/

import java_cup.runtime.*;

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
<YYINITIAL> "if"              { return symbol(token.IF); }
<YYINITIAL> "then"            { return symbol(token.THEN); }
<YYINITIAL> "else"            { return symbol(token.ELSE); }
<YYINITIAL> "while"            { return symbol(token.WHILE); }
<YYINITIAL> "int"            { return symbol(token.INT); }
<YYINITIAL> "float"            { return symbol(token.FLOAT); }


/*Whitespaces*/
<YYNITIAL> {WhiteSpace}      { /*ignora*/ }


/*Identificatori e Literals*/
<YYNITIAL>{
    {Identifier}            { return symbol(token.ID); }

    {IntegerNumber}         {return symbol(token.INUMBER);}

    {FloatingNumber}        {return symbol(token.FNUMBER);}

}

/*Separatori*/
<YYNITIAL>{
    "("           { return symbol(token.LPAR); }
    ")"           { return symbol(token.RPAR); }
    "{"           { return symbol(token.LCUR); }
    "}"           { return symbol(token.RCUR); }
    ","           { return symbol(token.COM); }
    ";"           { return symbol(token.SEMI); }
}

/*Operatori*/
<YYNITIAL>{
    "<--"           { return symbol(token.ASS); }
    "<"           { return symbol(token.LT); }
    "<="           { return symbol(token.LE); }
    ">"           { return symbol(token.GT); }
    ">="           { return symbol(token.GE); }
    "="           { return symbol(token.EQ); }
    "!="           { return symbol(token.NE); }
    "+"           { return symbol(token.ADD); }
    "-"           { return symbol(token.MIN); }
    "*"           { return symbol(token.MUL); }
    "/"           { return symbol(token.DIV); }
}

/*Commenti*/
<YYNITIAL> {Comment}      { /*ignora*/ }

/*String literals*/
\"                  { string.setLength(0); yybegin(STRING); }

<STRING> {
    \"              {
                        yybegin(YYINITIAL);
                        return symbol(token.STRING_LITERAL,
                        string.toString());
                    }
    [^\n\r\"\\]+    { string.append( yytext() ); }
    \\t             { string.append(’\t’); }
    \\n             { string.append(’\n’); }
    \\r             { string.append(’\r’); }
    \\\" { string.append(’\"’); }
    \\ { string.append(’\\’); }
}


/* error fallback */
[^]                {return symbol(token.ERROR,"-Carattere non consentito<"+
                    yytext()+"> a riga "+yyline()+"\n" );}
