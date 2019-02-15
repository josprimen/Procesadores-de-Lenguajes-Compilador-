class Analex extends Lexer;

options{
	importVocab=Anasint;
	k=2;
}

tokens{
	INICIO="BEGIN_CLASS_DIAGRAM";
	FIN="END_CLASS_DIAGRAM";
	CLASS="Class";
	INICIOO="BEGIN_OBJECT_DIAGRAM";
	FINN="END_OBJECT_DIAGRAM";
	ASSOCIATION="Association";
	BETWEEN="between";
	AND="and";
	MULTIPLICITY="Multiplicity";
	ON="on";
	IS="is";
	OBJECT="Object";
	LINK="Link";
	LINKEDOBJECTS="LinkedObjects";
}

protected NL:"\r\n" {newline();};
protected LETRA:'a'..'z'|'A'..'Z'|'_';
protected DIGITO: '0'..'9';

BTF: (' '|'\t'|NL) {$setType(Token.SKIP);};

IDENT: LETRA(LETRA|DIGITO)*;
NUM: (DIGITO)+;

MAYOR:'>';
MENOR:'<';
MAYORIGUAL:">=";
MENORIGUAL:"<=";
IGUAL:"=";

PA:'(';
PC:')';