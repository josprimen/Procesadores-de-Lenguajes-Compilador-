header{
	import antlr.*;
	import java.util.*;
}
class Anasint extends Parser;

options{
	k=2;
	buildAST=true;
}
tokens{
DIAGRAMA;
CLASES;
ASOCIACIONES;
RESTRICCIONES;
OBJETOS;
ENLACES;
}

{Set<AST> arboles_clase = new HashSet<AST>();
Set<AST> arboles_objeto = new HashSet<AST>();
ASTFactory factory = new ASTFactory();}

programa: diagrama_clase diagrama_objetos
{#programa=#(#[DIAGRAMA,"DIAGRAMA"],##);};

diagrama_clase: INICIO! (a:linea_clase {arboles_clase.add(factory.dupTree(#a));})* FIN!
{
	AST clases = null;
	AST asociaciones=null;
	AST restricciones=null;
	AST ultima_clase=null;
	AST asociacion_raiz=null;
	AST restriccion_raiz=null;
	for(AST e:arboles_clase){

	switch (e.getType()){
	
	case CLASS:
		if(clases==null){
			clases = factory.dupTree(e.getFirstChild());
			ultima_clase=clases;
		}else{
			ultima_clase.setNextSibling(e.getFirstChild());
			ultima_clase=ultima_clase.getNextSibling();
		}
	case ASSOCIATION:
		if(asociaciones==null){
			asociaciones = factory.dupTree(e);
			asociacion_raiz=asociaciones;
		}else{
			asociacion_raiz.setNextSibling(factory.dupTree(e));
			asociacion_raiz = asociacion_raiz.getNextSibling();
		}
	case MULTIPLICITY:
		if(restricciones==null){
			restricciones = factory.dupTree(e);
			restriccion_raiz=restricciones;
		}else{
			restriccion_raiz.setNextSibling(factory.dupTree(e));
			restriccion_raiz = restriccion_raiz.getNextSibling();
		}
	}
   }
   AST n1=new CommonAST();
   n1.setType(CLASES);
   n1.setText("CLASES");
   n1.setFirstChild(clases);
   AST n2=new CommonAST();
   n2.setType(ASOCIACIONES);
   n2.setText("ASOCIACIONES");
   n2.setFirstChild(asociaciones);
   n1.setNextSibling(n2);
   AST n3=new CommonAST();
   n3.setType(RESTRICCIONES);
   n3.setText("RESTRICCIONES");
   n3.setFirstChild(restricciones);
   n2.setNextSibling(n3);
   
   
   #diagrama_clase=n1;
};

linea_clase: dec_clases
	|asociaciones
	|restricciones
	;

dec_clases : PA! CLASS^ IDENT PC! ;

asociaciones: PA! ASSOCIATION^ IDENT BETWEEN! IDENT AND! IDENT PC!;

restricciones!: PA! x:MULTIPLICITY! a:IDENT ON! b:IDENT IS! c:operador d:NUM PC! 
    {#restricciones=#(#x,#a,#b,#c,#d);};

diagrama_objetos: INICIOO! (b:linea_objeto {arboles_objeto.add(factory.dupTree(#b));})* FINN!
{
	AST objetos = null;
	AST enlaces = null;
	AST ultimo_objeto = null;
	AST ultimo_enlace = null;
	for(AST e:arboles_objeto){
		switch (e.getType()){
			
			case OBJECT:
				if(objetos == null){
					objetos = factory.dupTree(e);
					ultimo_objeto = objetos;
				}else{
					ultimo_objeto.setNextSibling(factory.dupTree(e));
					ultimo_objeto = ultimo_objeto.getNextSibling();
				}
			case LINK:
				if(enlaces == null){
					enlaces = factory.dupTree(e);
					ultimo_enlace = enlaces;
				}else{
					ultimo_enlace.setNextSibling(factory.dupTree(e));
					ultimo_enlace = ultimo_enlace.getNextSibling();
				}
		}
	}
	
	AST nn1=new CommonAST();
   nn1.setType(OBJETOS);
   nn1.setText("OBJETOS");
   nn1.setFirstChild(objetos);
   AST nn2=new CommonAST();
   nn2.setType(ENLACES);
   nn2.setText("ENLACES");
   nn2.setFirstChild(enlaces);
   nn1.setNextSibling(nn2);
   
   
   
   #diagrama_objetos=nn1;
};

linea_objeto: objetos
	|enlaces
	;

objetos: PA! OBJECT^ IDENT CLASS IDENT PC!;

enlaces: PA! LINK^ IDENT ASSOCIATION! IDENT LINKEDOBJECTS! IDENT IDENT PC!;

operador: IGUAL | MAYOR | MENOR | MAYORIGUAL | MENORIGUAL ;