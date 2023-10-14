/*Import*/

%%

%class Lexer
%unicode
%line
%cupsym Token
%cup

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

%%
