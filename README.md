# Procesadores-de-Lenguajes-Compilador-
Compilador del lenguaje UMLTEXT realizado por José Enrique Prieto Menacho para la asignatura PL de I.Informática- TI en la Universidad de Sevilla

ENUNCIADO:
PROBLEMA 4: UMLTEXT

Supongamos un lenguaje llamado UMLTEXT diseñado para expresar textualmente diagramas de
clase y diagramas de objetos UML. Los diagramas de clase tienen la siguiente expresividad:
declaración de clase, declaración de asociación y declaración de restricciones de multiplicidad
sobre los extremos de la asociación. Un ejemplo de sentencia UMLTEXT es la siguiente:

BEGIN_CLASS_DIAGRAM //Diagrama de clase.
(Class A) //Clase A
(Class B) //Clase B
(Association R between A and B) //Asociación entre A y B
(Multiplicity R on A is = 1) //Restricción multiplicidad sobre R
 //en A
(Multiplicity R on B is >= 1) //Restricción multiplicidad sobre R
 //en B
END_CLASS_DIAGRAM
BEGIN_OBJECT_DIAGRAM //Diagrama de objetos.
(Object o1 Class A) //Objeto clase A
(Object o2 Class B) //Objeto clase B
(Object o3 Class A) //Objeto clase A
(Object o4 Class B) //Objeto clase B
(Link l1 Association R LinkedObjects o1 o2) //Enlace de R
(Link l2 Association R LinkedObjects o3 o2) //Enlace de R
END_OBJECT_DIAGRAM

PREPARAR ENTORNO DE DESARROLLO (eclipse mars): http://www.lsi.us.es/docencia/get.php?id=9152

PARA COMPROBAR EL FUNCIONAMIENTO:
1º Borrar A.java del default package(que se corresponde con la clase A del lenguaje UMLTEXT)
2º Borrar B.java del default package (que se corresponde con la clase B del lenguaje UMLTEXT)
3º Borrar AsociacionR.java del default package (que se corresponde con la asociación R del lenguaje UMLTEXT)
4º Borrar Fantasia.java del default package (que se corresponde con la creación de objetos y enlaces del lenguaje UMLTEXT)
5º Compilar Anasint2.g
6º Compilar Analex.g
7º Compilar Compilador2.g
8º Ejecutar Principal2.java
9º Refrescar proyecto (f5)


DISEÑO:

TRADUCCIÓN PROGRAMA EJEMPLO UMLTEXT --> Java
-----------------------------

(clase A)
(clase B)
(Asociación R entre A y B)
(Multiplicidad R en A = 1)
(Multiplicidad R en B >= 1)

(Objeto o1 de clase A)
(Objeto o2 de clase B)
(Objeto o3 de clase A)
(Objeto o4 de clase B)
(Enlace l1 de tipo R entre o1 y o2)
(Enlace l2 de tipo R entre o3 y o2)


###########################JAVA############################

----Clase A-----
package uml;

public class A {

	private String nombre;
	
	public A (String a){
		this.nombre = a;
	}
	
}
---------------

----Clase B-----
package uml;

public class B {

	private String nombre;

	public B(String b) {
		this.nombre = b;
	}

}
---------------

----Clase AsociacionR-----
package uml;

public class AsociacionR {

	A extremoIzq;
	B extremoDcho;
	// True si es = a 1 y false si es >=1
	Boolean multiplicidadA;
	Boolean multiplicidadB;

	public AsociacionR(A a, B b) {
		this.extremoIzq = a;
		this.extremoDcho = b;
		this.multiplicidadA = true;
		this.multiplicidadB = false;

	}

}
---------------

----Clase Principal-----
package uml;

public class Principal {

	public static void main(String[] args) {

		A o1 = new A("o1");
		B o2 = new B("o2");
		A o3 = new A("o3");
		B o4 = new B("o4");
		AsociacionR l1 = new AsociacionR(o1, o2);
		AsociacionR l2 = new AsociacionR(o3, o2);
	}

}
---------------







DISEÑO COMPILADOR UMLTEXT --> Java
-----------------------------

(clase A)
(clase B)
(Asociación R entre A y B)
(Multiplicidad R en A = 1)
(Multiplicidad R en B >= 1)

(Objeto o1 de clase A)
(Objeto o2 de clase B)
(Objeto o3 de clase A)
(Objeto o4 de clase B)
(Enlace l1 de tipo R entre o1 y o2)
(Enlace l2 de tipo R entre o3 y o2)

(1) Definir el esquema de traducción de un programa UMLTEXT

	-Necesitamos generar código de creación de clases para
	las clases UML.

	-Necesitamos generar código de creación de clases para
	las asociaciones.

	-Necesitamos generar código para añadir a las asociaciones
	las propiedades de multiplicidad.

	-Necesitamos generar código para la creación de objetos.

	-Necesitamos generar código para la creación de enlaces.

La creación de objetos y enlaces irá dentro de una clase principal.
	

(2) Detallar diseño métodos

	-codigo_creacion_clases (a): crea una clase con nombre a
	y un constructor (vacío).

	-codigo_creacion_asociaciones(a,b,c): crea una clase con nombre
	a y propiedades extremos (b,c) y multiplicidades de la asoc.

	-codigo_multiplicidad(m, n): settea o añade las multiplicidades
	como propiedades de la clase.

	-codigo_objetos(nombre, clase): crea objetos nombre de clase
	clase.
 
	-codigo_enlaces(nombre, clase, objeto1, objeto2): crea
	enlace nombre de tipo clase que une objeto1 y objeto2.


	Gramática atribuida resultante:
   	------------------------------


	programa: {generar codigo declaracion clase
                  generar codigo cabecera main}
		  diagrama_clase diagrama_objeto
		  {generar codigo fin main
                  generar codigo fin clase}

	diagrama_clase:(linea_clase)*

	linea_clase: dec_clases
		|asociaciones
		|restricciones

	dec_clases: #(CLASS a:IDENT)
		{codigo_creacion_clases(a)}

	asociaciones: #(ASSOCIATION a:IDENT b:IDENT c:IDENT)
		{codigo_creacion_asociaciones(a,b,c)}

	restricciones: #(MULTIPLICITY #(IDENT IDENT operador NUM))
		{codigo_multiplicidad(?)}

	diagrama_objetos:(linea_objeto)*

	linea_objeto: objetos
		|enlaces

	objetos: #(OBJECT a:IDENT b:IDENT)
		{codigo_objetos(a,b)}

	enlaces: #(LINK a:IDENT d:IDENT b:IDENT c:IDENT)
		{codigo_enlaces(a,d,b,c)}

	operador: IGUAL|MAYOR|MENOR|MAYORIGUAL|MENORIGUAL


----------------------------------------------------

generar codigo declaracion clase:
   escribir en fichero: 
         import java.io.*;
         public class _Programa{
   
generar codigo cabecera main:
   escribir en fichero:   public static void main(String[] args) {
      
generar codigo fin main:
   escribir en fichero:   } 
  
generar codigo fin clase:  
   escribir en fichero: } 

generar codigo constructor vacio:
   escribir en fichero:
	public nombre (String a){
	}
  
  
  
  
  
  
  NOTA:
  La dificultad principal fue el desconocimiento de que el anasint genera un ASA que más tarde es el que consume el compilador.
  Los anasint y principal son versiones intermedias no finales que surgieron durante el desarrollo.
  
  
  AGRADECIMIENTOS:
  Naroa Alonso Fernández y Luís Cortés Ferre por echarme una mano en el desarrollo de la versión final.
