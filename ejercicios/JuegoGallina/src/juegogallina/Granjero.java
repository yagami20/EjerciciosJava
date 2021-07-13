/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package juegogallina;
import javax.swing.*;
import java.awt.*;
/**
 *
 * @author EstephanyJaneth
 */
public class Granjero extends JApplet implements Runnable
{
    Escenario Escena=new Escenario();

    @Override
    public void init()
    {
        this.setSize(396,325);

        Escena.setBounds(new Rectangle(0,35,396,325));
        this.add(Escena);
    }

    public void run() {
        Escena.run();
    }
}
