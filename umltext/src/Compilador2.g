header{

import java.util.*;
import antlr.*;
import java.io.*;}

class Compilador extends TreeParser; // Compilador
options
{
   importVocab = Anasint;
}
{

//Generar espacios

    int espacios = 0;

	private void gencode_espacios(BufferedWriter bw) {
		try {
			for (int i = 1; i <= espacios; i++)
				bw.write("   ");
		} catch (IOException e) {
			System.out.println("gencode_espacios (exception): " + e.toString());
		}
	}

	// String i = "Fantasia";

	FileWriter fichero;

	private void open_file() {
		try {
			fichero = new FileWriter("src/Fantasia.java");
		} catch (IOException e) {
			System.out.println("open_file (exception): " + e.toString());
		}
	}

	private void gencode_begin_class() {
		try {
			fichero.write("import java.io.*;\n");
			fichero.write("public class Fantasia");
			fichero.write("{\n");
			// general.flush();
		} catch (IOException e) {
		}
	}

	private void gencode_begin_main() {
		try {
			fichero.write("public static void main(String[] args) {\n");
			// general.flush();
		} catch (IOException e) {
		}
	}

	private void gencode_end_main() {
		try {
			fichero.write("}\n");
			// general.flush();

		} catch (IOException e) {
		}
	}

	private void gencode_end_class() {
		try {
			fichero.write("}");
			// general.flush();

		} catch (IOException e) {
		}
	}

	private void close_file() {
		try {
			fichero.close();
		} catch (IOException e) {
			System.out.println("close_file (exception): " + e.toString());
		}
	}

	// ######################################################################################//

	public void codigo_creacion_clase(String a) {
		try {
			FileWriter f;
			f = new FileWriter("src/" + a + ".java");
			BufferedWriter bw = new BufferedWriter(f);
			bw.write("import java.io.*;\n");
			bw.write("public class " + a.toUpperCase());
			bw.write("{\n\n");
			bw.write("\tprivate String nombre; \n\n \tpublic " + a.toUpperCase()
					+ "(String a){\n \t\tthis.nombre = a;\n\t}\n}");
			bw.flush();
			f.close();
		} catch (IOException e) {
		}
	}

	public void codigo_creacion_asociaciones(String a, String b, String c, List<String> l1, List<String> l2) {
		try {
			FileWriter f;
			f = new FileWriter("src/Asociacion" + a.toUpperCase() + ".java");
			BufferedWriter bw = new BufferedWriter(f);

			bw.write("import java.util.ArrayList;\n");
			bw.write("import java.util.List;\n");
			bw.write("public class AsociacionR {\n");

			espacios++;
			gencode_espacios(bw);
			bw.write(b.toUpperCase() + " extremoIzq;\n");
			gencode_espacios(bw);
			bw.write(c.toUpperCase() + " extremoDcho;\n");
			gencode_espacios(bw);
			bw.write("List<String> multiplicidadDer;\n");
			gencode_espacios(bw);
			bw.write("List<String> multiplicidadIzq;\n");

			espacios++;
			gencode_espacios(bw);
			bw.write(
					"public Asociacion" + a.toUpperCase() + "(" + b.toUpperCase() + " a," + c.toUpperCase() + " b){\n");
			// bw.write("List<String> l1, List<String> l2){\n");
			espacios++;
			gencode_espacios(bw);
			bw.write("this.extremoIzq = a;\n");
			gencode_espacios(bw);
			bw.write("this.extremoDcho = b;\n");
			gencode_espacios(bw);
			bw.write("this.multiplicidadDer = new ArrayList<>();\n");
			gencode_espacios(bw);
			bw.write("this.multiplicidadIzq = new ArrayList<>();\n");
			gencode_espacios(bw);
			bw.write("multiplicidadIzq.add(\"" + l1.get(0) + "\");\n");
			gencode_espacios(bw);
			bw.write("multiplicidadIzq.add(\"" + l1.get(1) + "\");\n");
			gencode_espacios(bw);
			bw.write("multiplicidadIzq.add(\"" + l2.get(0) + "\");\n");
			gencode_espacios(bw);
			bw.write("multiplicidadIzq.add(\"" + l2.get(1) + "\");\n");
			bw.write("\n\t}\n}");

			espacios = espacios - 2;
			bw.flush();
			f.close();
		} catch (IOException e) {
		}
	}

	public void codigo_objetos(String a, String b) {
		try {
			fichero.write(b.toUpperCase() + " " + a + " = new " + b.toUpperCase() + "(\"" + a + "\");\n");
			// general.flush();

		} catch (IOException e) {
		}
	}

	public void codigo_enlaces(String a, String b, String c, String d) {
		try {
			fichero.write("Asociacion" + b.toUpperCase() + " " + a + " = new Asociacion" + b.toUpperCase() + "(" + c
					+ "," + d + ");\n");
			// general.flush();

		} catch (IOException e) {
		}
	}

	// ######################################################################################//

	// ------------------

	}

	programa:#(PROGRAMA{open_file();gencode_begin_class();gencode_begin_main();}

	diagrama_clases   diagrama_objetos)
	{
		gencode_end_main();
		gencode_end_class();
		close_file();
	};

	diagrama_clases
	{String s;}:#(

	DIAGRAMACLASE (s = clase {codigo_creacion_clase(s);})+ (asociacion)+);

clase returns[String s = null]: #(CLASS a:IDENT {s = a.getText();});

asociacion {List<String> l1,l2;}: #(ASSOCIATION a:IDENT b:IDENT c:IDENT l1 = multiplicidad l2 = multiplicidad
) {codigo_creacion_asociaciones(a.getText(), b.getText(), c.getText(),l1,l2);};

multiplicidad returns[List<String> l = null]: #(MULTIPLICITY a:IDENT IDENT l = operacion);

operacion returns [List<String> s = new ArrayList<>()] {}: 
	  #(IGUAL a:NUM) {s.add("=");s.add(a.getText());}
	| #(MAYOR b:NUM) {s.add(">");s.add(b.getText());}
	| #(MENOR c:NUM) {s.add("<");s.add(c.getText());}
	| #(MAYORIGUAL d:NUM) {s.add(">=");s.add(d.getText());}
	| #(MENORIGUAL e:NUM) {s.add("<=");s.add(e.getText());}
	;

diagrama_objetos: #(DIAGRAMAOBJETOS (objeto)+ (enlace)+);

objeto {String s;}: #(OBJECT a:IDENT s=clase {codigo_objetos(a.getText(),s);});

enlace: #(LINK a:IDENT b:IDENT c:IDENT d:IDENT {codigo_enlaces(a.getText(),b.getText(),c.getText(),d.getText());});