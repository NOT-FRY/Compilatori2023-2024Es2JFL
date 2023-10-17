package jflex.generated;
import java_cup.runtime.Symbol;

import java.io.FileReader;
import java.io.FileNotFoundException;

public class Main {
    public static void main(String[] args) {
        Lexer lexicalAnalyzer = null;
        try {
            if (args.length == 0) {
                System.out.println("Usage: java Main <input_file>");
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
                    System.out.println(Token.getTokenStr(token));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
