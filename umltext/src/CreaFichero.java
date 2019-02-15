import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;

public class CreaFichero {

	public static void main(String[] args) {
		FileWriter f;
		try{
		f = new FileWriter("src/aznaaar.txt");
		f.write("Hola");
		
		f.close();
			}
		catch(IOException e){
			   {System.out.println("open_file (exception): "+e.toString());}
			}
		codigo_creacion_clase("a");
		codigo_creacion_asociaciones("r","a","b");
		codigo_multiplicidad("r","=");
		codigo_multiplicidad("r",">=");
	}
	
	 private static void codigo_creacion_clase(String a){
		    try{
		    	FileWriter f;
		    	f = new FileWriter("src/"+a+".txt");
		    	BufferedWriter bw=new BufferedWriter(f);
		    	//gencode_espacios();
		    	bw.write("import java.io.*;\n");
		    	//gencode_espacios();
		    	bw.write("public class "+ a.toUpperCase());
		    	//gencode_espacios();
		    	bw.write("{\n\n");
		    	bw.write("private String nombre; \n\n public "+ a.toUpperCase() + "(String a){\n this.nombre = a;\n\t}\n}");
		    	//f.close();
		    	bw.flush();
		    	f.close();
		    }catch(IOException e){}
		    }


		     private static void codigo_creacion_asociaciones(String a, String b, String c){
		    try{
		    	FileWriter f;
		    	f = new FileWriter("src/"+a+".txt");
		    	BufferedWriter bw=new BufferedWriter(f);
		    	//gencode_espacios();
		    	bw.write("import java.io.*;\n");
		    	//gencode_espacios();
		    	bw.write("public class asociation"+ a.toUpperCase());
		    	//gencode_espacios();
		    	bw.write("{\n\n" + b.toUpperCase() + " extremoIzq;\n" + c.toUpperCase() + " extremoDch;\n" + "Boolean multiplicidad1;\n" + "Boolean multiplicidad2;\n\n");
		    	bw.write("public asociation"+ a.toUpperCase() + "(" + b.toUpperCase() + " a, " + c.toUpperCase() + " b){\n");
		    	bw.write("this.extremoIzq = a;\n this.extremoDch = b;\n}\t\n");
		    	//f.close();
		    	bw.flush();
		    	f.close();
		    }catch(IOException e){}
		    }
		     
		     
		     static int contaca = 0;
			 private static void codigo_multiplicidad(String clase, String operador){
			 try{
				// FileWriter writer1 = new FileWriter(filename, true); 
			 	FileWriter f;
		    	f = new FileWriter("src/"+clase+".txt", true);
		    	BufferedWriter bw=new BufferedWriter(f);
				 //gencode_espacios();
				 if(contaca==0){
					 if (operador == "="){
						 //true si la multiplicidad del extremo es igual a 1
					 bw.write("multiplicidad1 = true;\n");
				 }else{
					 //false si la multiplicidad del extremo es mayor o igual a 1
					 bw.write("multiplicidad1 = false;\n");
				 }
				 contaca++;
			 }else{
				 if (operador == "="){
					 //true si la multiplicidad del extremo es igual a 1
				 bw.write("multiplicidad2 = true;\n");
			 }else{
				 //false si la multiplicidad del extremo es mayor o igual a 1
				 bw.write("multiplicidad2 = false;\n");
				 
			 }
			 contaca--;
			 }
				 bw.flush();
				f.close();
			 }catch(IOException e){}
			 }
	

}

