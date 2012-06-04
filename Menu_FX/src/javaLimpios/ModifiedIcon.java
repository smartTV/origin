/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package javaLimpios;
import java.awt.Image;
import java.awt.Toolkit;
import javax.swing.ImageIcon;

/**
 *
 * @author Spook
 */
public class ModifiedIcon extends ImageIcon{
    public ModifiedIcon(){

    }

    public void setImage(String filename){
        Image image;
        image = Toolkit.getDefaultToolkit().getImage(filename);
        if (image == null) {
            return;
        }
        setDescription(filename);
        loadImage(image);
    }
    
}
