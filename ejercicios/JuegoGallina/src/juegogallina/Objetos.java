/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package juegogallina;

/**
 *
 * @author EstephanyJaneth
 */
public class Objetos<T>
{
    private Elemento p=null;

    private class Elemento
    {
        private T datos;
        private Elemento sig;

        private Elemento(){}
        private Elemento(T d, Elemento s)
        {
            datos=d;
            sig=s;
        }
    }
    public Objetos(){}
    public int nFiguras()
    {
        Elemento q=p;
        int n=0;
        while(q!=null)
        {
            n++;
            q=q.sig;
        }
        return n;
    }
    public void Insertar(T obj, int i)
    {
        int nfig=nFiguras();
        Elemento q=new Elemento(obj,null);
        if(nfig==0)
        {
            p=q;
            return;
        }
        Elemento ant=p;
        Elemento act=p;
        for(int n=0; n<i; n++)
        {
            ant=act;
            act=act.sig;
        }
        if(ant==act)
        {
            q.sig=p;
            p=q;
        }
        else
        {
            q.sig=act;
            ant.sig=q;
        }
    }
    public T Obtener(int i)
    {
        int nfig=nFiguras();
        if(i>=nfig || i<0)return null;

        Elemento q=p;
        for(int n=0; n<i; n++)
            q=q.sig;
        return q.datos;
    }
    public T Sacar()
    {
        Elemento q=p;
        if(this.nFiguras()!=0)
            p=p.sig;

        return q.datos;
    }
    public void InsertarFigura(T obj)
    {
        Insertar(obj,nFiguras());
    }
}
