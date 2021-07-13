import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import java.util.Stack;
import java.util.Iterator;

class Jarras {
 

	int j4, j3;
	List<Jarras> hijos;
	int nodosAnalizados, largoBusqueda;
	
	public Jarras(int j4, int j3)
	{
		this.j4 = j4;
		this.j3 = j3;
		hijos = new ArrayList<Jarras>();
	}
 
   public void addHijos(Jarras hijo)
   {
   	hijos.add(hijo);
   }
   
   
    public void Estados()
    {
    	int ij4;
    	int ij3;
    	
    	for (int operador = 0; operador < 6;operador++)
    	{
    		
                        
                        
                       //llenar garrafa de 4L
                        if (operador == 0 && this.j4<4 ){
                                ij4 = 4;
                                ij3 = this.j3;
                                Jarras nodo = new Jarras(ij4,ij3);
                                hijos.add(nodo);
                        } 
                        
                        //llenar garrafa de 3L
                        if (operador == 1 && this.j3<3 ){
                        	 	ij4 = this.j4;
                                ij3 = 3;   
                                Jarras nodo = new Jarras(ij4,ij3);
                                hijos.add(nodo);
                        }
                        
                        //vaciar garrafa de 4L
                        if (operador == 2 && this.j4>0 ){
                                ij4 = 0;
                                ij3 = this.j3;
                                Jarras nodo = new Jarras(ij4,ij3);
                                hijos.add(nodo);
                        }
                        //vaciar garrafa de 3L
                        if (operador == 3 && this.j3>0 ){
                                ij4 = this.j4;
                                ij3 = 0;
                                Jarras nodo = new Jarras(ij4,ij3);
                                hijos.add(nodo);
                        }
                        //verter garrafa de 3L sobre garrafa de 4L
                        if (operador == 4 && this.j3>0 && this.j4<4 ){
                                if (this.j3+this.j4 <= 4){
                                        ij4=this.j3+this.j4;
                                        ij3=0;
                                        Jarras nodo = new Jarras(ij4,ij3);
                               			 hijos.add(nodo);
                                }
                                else {
                                        ij4 = 4;
                                        ij3 = (this.j3+this.j4)-4;
                                        Jarras nodo = new Jarras(ij4,ij3);
                               			 hijos.add(nodo);
                                }
                               
                        }
                        //verter garrafa de 4L sobre garrafa de 3L
                        if (operador == 5 && this.j4>0 && this.j3<3 ){
                                if (this.j3+this.j4 <= 3){
                                        ij3=this.j3+this.j4;
                                        ij4=0;
                                        Jarras nodo = new Jarras(ij4,ij3);
                               			 hijos.add(nodo);
                                }
                                else {
                                        ij3 = 3;
                                        ij4 = this.j4-(3-this.j3);
                                        Jarras nodo = new Jarras(ij4,ij3);
                               			 hijos.add(nodo);
                                }
                                
                        }
    	}
    	
    }
    
    
    public String getEstado()
    {
    	return "("+j4+","+j3+")";
    }
    
    
     public List<Jarras> getHijos() {


        return hijos;


    }
    
    public int getNodosAnalizados()
    {
    	return nodosAnalizados;
    }
    
    public int getLargoBusqueda()
    {
    	return largoBusqueda;
    }
    
   
   
   
   	
	public boolean busquedaAnchura() {
	
		
	    List<Jarras> recorridos = new ArrayList<Jarras>();
        Queue<Jarras> colaAuxiliar = new LinkedList<Jarras>();
        colaAuxiliar.add(this);
		Iterator<Jarras> nombreIterator;
		boolean estado;
		nodosAnalizados = 0;
		largoBusqueda = 0;


        while(colaAuxiliar.size() != 0) 
        {

            Jarras cabeza = colaAuxiliar.poll();
			estado = true;
			nombreIterator = recorridos.iterator();
			
			while(nombreIterator.hasNext())
			{
				Jarras compar = nombreIterator.next();
				
				if((cabeza.j4 == compar.j4) && (cabeza.j3 == compar.j3))
				{
					estado = false;
					break;
				}
			}
			
			if(estado == true)
			{
		
            	System.out.println(cabeza.getEstado() );  // solo añadido como informacion para nosotros
				recorridos.add(cabeza);
				nodosAnalizados++;

           		 if(cabeza.j4 == 2 )
           		 {
           		     return true;
          	 	 }
          	 	 
          		 else
        	    {
					cabeza.Estados();
             	   for(Jarras hijo : cabeza.getHijos())
             	   {
             	   	largoBusqueda++;
               	     colaAuxiliar.add(hijo);
             	   }                   
          	    }	
		   }			
        }

        return false;


    }
   
   
   
   	public boolean busquedaProfundidad() {
	
		
	    List<Jarras> recorridos = new ArrayList<Jarras>();
        Stack<Jarras> pilaAuxiliar = new Stack<Jarras>();
        pilaAuxiliar.push(this);
		Iterator<Jarras> nombreIterator;
		boolean estado;
		nodosAnalizados = 0;
		largoBusqueda = 0;

        while(pilaAuxiliar.size() != 0) 
        {

            Jarras cabeza = pilaAuxiliar.pop();
			estado = true;
			nombreIterator = recorridos.iterator();
			
			while(nombreIterator.hasNext())
			{
				Jarras compar = nombreIterator.next();
				
				if((cabeza.j4 == compar.j4) && (cabeza.j3 == compar.j3))
				{
					estado = false;
					break;
				}
			}
			
			if(estado == true)
			{
		
            	System.out.println(cabeza.getEstado() );  // solo añadido como informacion para nosotros
				recorridos.add(cabeza);
				nodosAnalizados++;

           		 if(cabeza.j4 == 2 )
           		 {
           		     return true;
          	 	 }
          	 	 
          		 else
        	    {
        	    	
					cabeza.Estados();
					
					for(int i = 0;i < pilaAuxiliar.size(); i++)
					{
						Jarras p = pilaAuxiliar.get(i);
						for(int j=0; j < cabeza.getHijos().size();j++)
						{
							Jarras p2 = cabeza.getHijos().get(j);
							if((p2.j4 == p.j4) && (p2.j3 == p.j3))
							{
								cabeza.hijos.remove(j);
							}
						}
							
					}		
             	   		for(int i = cabeza.getHijos().size() -1; i >= 0;i--)
             	   		{
             	   			largoBusqueda++;
               	     		pilaAuxiliar.push(cabeza.getHijos().get(i));
             	   		} 
					}                  
          	    }	
		   }
		    return false;			
        }

       


    }
   
    



class MainJarras
{


public static void main (String[] args) {
	
	Jarras inicio = new Jarras(0,0);
	System.out.println("BUSQUEDA EN ANCHURA");
	inicio.busquedaAnchura();
	System.out.println("Nodos Analizados :"+inicio.getNodosAnalizados());
	System.out.println("Largo Busqueda :"+inicio.getLargoBusqueda());	
	System.out.println();	
	System.out.println("BUSQUEDA EN PROFUNDIDAD");
	inicio.busquedaProfundidad();
	System.out.println("Nodos Analizados :"+inicio.getNodosAnalizados());
	System.out.println("Largo Busqueda :"+inicio.getLargoBusqueda());
}

}