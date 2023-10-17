package jflex.generated;

import java_cup.runtime.Symbol;

public class Token {

    public static final int ERROR=-1;
    public static final int EOF=0;
    public static final int IF=1;
    public static final int THEN=2;
    public static final int ELSE=3;
    public static final int WHILE=4;
    public static final int INT=5;
    public static final int FLOAT=6;
    public static final int ID=7;
    public static final int INUMBER=8;
    public static final int FNUMBER=9;
    public static final int LPAR=10;
    public static final int RPAR=11;
    public static final int LCUR=12;
    public static final int RCUR=13;
    public static final int COM=14;
    public static final int SEMI=15;
    public static final int ASS=16;
    public static final int LT=17;
    public static final int LE=18;
    public static final int GT=19;
    public static final int GE=20;
    public static final int EQ=21;
    public static final int NE=22;
    public static final int ADD=23;
    public static final int MIN=24;
    public static final int MUL=25;
    public static final int DIV=26;
    public static final int STRING_LITERAL=27;


    public static String getTokenStr(Symbol token) {
        switch (token.sym) {
            case Token.ERROR:
                return "ERROR";
            case Token.IF:
                return "IF";
            case Token.THEN:
                return "THEN";
            case Token.ELSE:
                return "ELSE";
            case Token.WHILE:
                return "WHILE";
            case Token.INT:
                return "INT";
            case Token.FLOAT:
                return "FLOAT";
            case Token.ID:
                return "ID";
            case Token.INUMBER:
                return "INUMBER";
            case Token.FNUMBER:
                return "FNUMBER";
            case Token.LPAR:
                return "LPAR";
            case Token.RPAR:
                return "RPAR";
            case Token.LCUR:
                return "LCUR";
            case Token.COM:
                return "COM";
            case Token.SEMI:
                return "SEMI";
            case Token.ASS:
                return "ASS";
            case Token.LT:
                return "LT";
            case Token.LE:
                return "LE";
            case Token.GT:
                return "GT";
            case Token.GE:
                return "GE";
            case Token.EQ:
                return "EQ";
            case Token.NE:
                return "NE";
            case Token.ADD:
                return "ADD";
            case Token.MIN:
                return "MIN";
            case Token.MUL:
                return "MUL";
            case Token.DIV:
                return "DIV";
            case Token.STRING_LITERAL:
                return "STRING_LITERAL";

            default:
                return "Token non riconosciuto";
        }
    }
}
