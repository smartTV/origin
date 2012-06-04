package Menus;

import javafx.scene.*;
import javafx.scene.image.*;
import javafx.scene.media.MediaView;
import javafx.scene.media.MediaPlayer;
import javafx.scene.media.Media;
import java.awt.Toolkit;

def S = Main.S;
package def THUMB_ICON = Main.makeImage("video1.png");

package class Video extends Scenario {
    init {
        children = [
            ImageView { image: Main.makeImage(__DIR__,"menu2.jpg") },
            MediaView
            {
                fitWidth: bind Toolkit.getDefaultToolkit().getScreenSize().width
                fitHeight: bind Toolkit.getDefaultToolkit().getScreenSize().height
                
                mediaPlayer: MediaPlayer
                {
                    autoPlay: true

                    media: Media
                    {
                      source: "http://projavafx.com/movies/elephants-dream-640x352.flv"
                    }
                }
            }
            ]
    }

    public override function play() {
       
    }

    public override function pause() {
       
    }
}
