import java.util.ArrayList;
import java.util.List;
public class AsociacionR {
   A extremoIzq;
   B extremoDcho;
   List<String> multiplicidadDer;
   List<String> multiplicidadIzq;
      public AsociacionR(A a,B b){
         this.extremoIzq = a;
         this.extremoDcho = b;
         this.multiplicidadDer = new ArrayList<>();
         this.multiplicidadIzq = new ArrayList<>();
         multiplicidadIzq.add("=");
         multiplicidadIzq.add("1");
         multiplicidadIzq.add(">=");
         multiplicidadIzq.add("1");

	}
}