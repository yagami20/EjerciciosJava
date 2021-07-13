package juegogallina;

import java.awt.*;
import javax.swing.*;


/**
 *
 * @author EstephanyJaneth
 */
public class Escenario extends Canvas implements Runnable{
    String fondo;
    String granjero;
    Image imagenFondo;
    Image imagenCosa;
    Image imagenGranjero;

    Objetos<figuras> sinCruzar=new Objetos<figuras>();
    Objetos<figuras> yaCruzado=new Objetos<figuras>();

    public int xG,yG;

    int minX=45;
    int maxX=340;

    Thread hilo;
    boolean derecha=true;

    figuras fig=null;
    figuras figc=null;

    public Escenario()
    {
        fondo="images/rio.jpg";
        imagenFondo= new ImageIcon(fondo).getImage();
        granjero="images/g.png";
        imagenGranjero= new ImageIcon(granjero).getImage();
        xG=minX;
        yG=180;
        cargarObjetos();
        hilo=new Thread(this);
        hilo.start();
    }

    public void run()
    {
        while(true)
        {
            Llevar();
            if(derecha)
            {
                xG+=5;
                repaint();
            }
            else
            {
                xG-=5;
                repaint();
            }
           Traer();
            try
            {
                hilo.sleep(50);
            }catch(Exception e){}
            try
            {
                if(sinCruzar.nFiguras()==0 && xG>=maxX)
                {
                    granjero="images/g.png";
                    imagenGranjero= new ImageIcon(granjero.replace(" ", "")).getImage();
                    repaint();
                    hilo.stop();
                }
            }catch(Exception e){}
        }
    }
    public void Llevar()
    {
        if(xG<=minX)
        {
            if(fig!=null)
                sinCruzar.InsertarFigura(fig);
            //fig=null;
        }
        int kn=0;
        int k=sinCruzar.nFiguras();
        char[] n=new char[3];
            n[0]=' ';n[1]=' ';n[2]=' ';
            kn=0;
            
         if(derecha && xG<=minX)
         {
           fig=(figuras)sinCruzar.Sacar();
                k=sinCruzar.nFiguras();
                while(kn<k)
                {
                    figc=(figuras)sinCruzar.Obtener(kn);
                    n[kn]=figc.tipo;
                    kn++;
                }
                if(validaPareja(n[0],n[1]) || validaPareja(n[1],n[0]))
                {
                    granjero="images/g"+fig.tipo;
                    granjero+=".png";
                    imagenGranjero= new ImageIcon(granjero.replace(" ", "")).getImage();
               }
           while(!validaPareja(n[0],n[1]) || !validaPareja(n[1],n[0]))
           {
               kn=0;
                k=sinCruzar.nFiguras();
                while(kn<k)
                {
                    figc=(figuras)sinCruzar.Obtener(kn);
                    n[kn]=figc.tipo;
                    kn++;
                }
                if(validaPareja(n[0],n[1]) || validaPareja(n[1],n[0]))
                {
                    granjero="images/g"+fig.tipo;
                    granjero+=".png";
                    imagenGranjero= new ImageIcon(granjero.replace(" ", "")).getImage();
                    break;
               }
                else
                {
                    sinCruzar.InsertarFigura(fig);
                    fig=(figuras)sinCruzar.Sacar();
                }
           }
        }        
    }
    public void Traer()
    {
            //********************
        if(xG>maxX-2)
        {
            yaCruzado.InsertarFigura(fig);
            fig=null;
        }
        int kn=0;
        int k;
        char[] n=new char[3];
            n[0]=' ';n[1]=' ';n[2]=' ';
            kn=0;
         if(derecha && (xG)>=maxX)
         {
           n[0]=' ';n[1]=' ';n[2]=' ';
                k=yaCruzado.nFiguras();
                while(kn<k)
                {
                    figc=(figuras)yaCruzado.Obtener(kn);
                    n[kn]=figc.tipo;
                    kn++;
                }
                if(validaPareja(n[0],n[1]) || validaPareja(n[1],n[0]))
                {
                    granjero="images/g";
                    granjero+="r.png";
                    imagenGranjero= new ImageIcon(granjero.replace(" ", "")).getImage();
               }
               else
               {
                    fig=(figuras)yaCruzado.Sacar();
                    if(fig!=null)
                        granjero="images/g"+fig.tipo;
                    else
                        granjero="images/g";
                    granjero+="r.png";
                    imagenGranjero= new ImageIcon(granjero.replace(" ", "")).getImage();
		    //sinCruzar.InsertarFigura(fig);
                }
           
        }
        /*---------------------------------*/
            if(xG<=minX)
                derecha=true;
            if(xG>=maxX)
                derecha=false;
    }
    @Override
    public void paint(Graphics g)
    {
        g.drawImage(imagenFondo, 0, 0, imagenFondo.getWidth(this), imagenFondo.getHeight(this), this);
        int kn=0;

        figuras fig1;
        int k=sinCruzar.nFiguras();
        while(kn<k)
        {
            fig1=(figuras)sinCruzar.Obtener(kn);
            imagenCosa= new ImageIcon(fig1.MiIcono).getImage();
            g.drawImage(imagenCosa, 40-kn*16, 170+kn*9, imagenCosa.getWidth(this), imagenCosa.getHeight(this), this);
            kn++;
        }
        kn=0;
        k=yaCruzado.nFiguras();
        while(kn<k)
        {
            fig1=(figuras)yaCruzado.Obtener(kn);
            imagenCosa= new ImageIcon(fig1.MiIcono).getImage();
            g.drawImage(imagenCosa, maxX+kn*16, 170+kn*9, imagenCosa.getWidth(this), imagenCosa.getHeight(this), this);
            kn++;
        }
        g.drawImage(imagenGranjero, xG, yG, imagenGranjero.getWidth(this), imagenGranjero.getHeight(this), this);
    }
    public void cargarObjetos()
    {
         sinCruzar.InsertarFigura(new figuras("Maiz", 'm', "m.png"));
         sinCruzar.InsertarFigura(new figuras("Pollo", 'p', "p.png"));
         sinCruzar.InsertarFigura(new figuras("Zorro", 'z', "z.png"));
    }

    public boolean validaPareja(char O1, char O2)
    {
        boolean identifica=false;
        switch(O1)
        {
            case 'p':
            {
                switch(O2)
                {
                    case ' ':
                        identifica=true;
                    break;
                    case 'z':
                        identifica=false;
                    break;
                    case 'm':
                        identifica=false;
                    break;
                }
            }break;
            case 'm':
            {
                switch(O2)
                {
                    case ' ':
                        identifica=true;
                    break;
                    case 'z':
                        identifica=true;
                    break;
                    case 'p':
                        identifica=false;
                    break;
                }
            }break;
            case 'z':
            {
                switch(O2)
                {
                    case ' ':
                        identifica=true;
                    break;
                    case 'p':
                        identifica=false;
                    break;
                    case 'm':
                        identifica=true;
                    break;
                }
            }break;
            case ' ':
            {
                switch(O2)
                {
                    case ' ':
                        identifica=true;
                    break;
                    case 'z':
                        identifica=true;
                    break;
                    case 'm':
                        identifica=true;
                    break;
                    case 'p':
                        identifica=true;
                    break;
                }
            }break;
        }
        return identifica;
    }
}
