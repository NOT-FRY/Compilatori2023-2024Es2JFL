package jflex.generated;
import java_cup.runtime.Symbol;

import java.io.FileReader;
import java.io.FileNotFoundException;

public class Tester {
    public static void main(String[] args) {
        Lexer lexicalAnalyzer = null;
        try {
            if (args.length == 0) {
                System.out.println("Argomenti insufficienti\n Inserire il nome del file come parametro");
                return;
            }

            lexicalAnalyzer = new Lexer(new FileReader(args[0]));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        if (lexicalAnalyzer != null) {
            try {
                Symbol token;
                while ((token = lexicalAnalyzer.next_token()).sym != Token.EOF) {
                    System.out.print(Token.getTokenStr(token)+" ");
                    if(token.value!=null)
                        System.out.print(token.value.toString());
                    System.out.println();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
