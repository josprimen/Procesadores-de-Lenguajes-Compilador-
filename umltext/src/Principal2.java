import java.io.FileInputStream;
import java.io.FileNotFoundException;


import antlr.RecognitionException;
import antlr.TokenStreamException;
import antlr.collections.AST;
import antlr.debug.misc.ASTFrame;


public class Principal2{
	
	
	public static void main(String[] args) {
		
		try{
			
			FileInputStream f = new FileInputStream(args[0]);
			Analex analex = new Analex(f);
			Anasint anasint = new Anasint(analex);
			

			
	// Análisis léxico-sintáctico
			anasint.programa();
			AST a = anasint.getAST();
			ASTFrame af = new ASTFrame(args[0],a);
			af.setVisible(true);
			
			Compilador compilador = new Compilador();
		   	compilador.programa(a);

		}catch(FileNotFoundException e)
			{System.out.println("Error in file");}
		catch(RecognitionException e)
			{System.out.println("Error in parser analysis");}
		catch(TokenStreamException e)
			{System.out.println("Error in lexical analysis");}
		}
	    
		
	   	
	}