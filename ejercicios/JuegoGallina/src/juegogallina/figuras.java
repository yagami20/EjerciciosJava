/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package juegogallina;
import java.awt.*;
/**
 *
 * @author EstephanyJaneth
 */
public class figuras {
//import Figuras.*;
    public String Nombre;
    public char tipo;
    public String MiIcono;

    public figuras(){}
    public figuras(String fg, char tp, String x)
    {
        tipo=tp;
        Nombre=fg;
        MiIcono="images/"+x;
    }
}
