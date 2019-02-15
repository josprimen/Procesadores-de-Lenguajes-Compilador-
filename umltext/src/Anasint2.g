class Anasint extends Parser;

options{
	k=2;
	buildAST=true;
}
tokens{
PROGRAMA;
DIAGRAMACLASE;
DIAGRAMAOBJETOS;
}

programa:diagrama_clase diagrama_objetos
{#programa = #(#[PROGRAMA, "PROGRAMA"], ##);}
;

diagrama_clase: INICIO! (linea_clase)* FIN!
{#diagrama_clase = #(#[DIAGRAMACLASE, "DIAGRAMA_CLASE"], ##);};

linea_clase: dec_clases
	|asociaciones
	;

dec_clases: PA! clase PC!;

clase: CLASS^ IDENT;

asociaciones: PA! ASSOCIATION^ IDENT BETWEEN! IDENT AND! IDENT PC! multiplicidad multiplicidad;

multiplicidad: PA! MULTIPLICITY^ IDENT ON! IDENT IS! operador PC!;

diagrama_objetos: INICIOO! (linea_objeto)* FINN!
{#diagrama_objetos = #(#[DIAGRAMAOBJETOS, "DIAGRAMA_OBJETOS"], ##);};

linea_objeto: objetos
	|enlaces
	;

objetos: PA! OBJECT^ IDENT clase PC!;

enlaces: PA! LINK^ IDENT ASSOCIATION! IDENT LINKEDOBJECTS! IDENT IDENT PC!;

operador: (IGUAL^ | MAYOR^ | MENOR^ | MAYORIGUAL^ | MENORIGUAL^) NUM ;