package Menus;

import javafx.animation.*;
import javafx.animation.transition.*;
import javafx.scene.*;
import javafx.scene.image.*;
import javafx.scene.media.MediaView;
import javafx.scene.media.MediaPlayer;
import javafx.scene.media.Media;

def S = Main.S;
def PADDING = 2;
def track_strokeWidth = 20 * S;
def line_strokewidth = 2;
package def THUMB_ICON = Main.makeImage("config.png");

package class Config extends Scenario
{

    init{
        children = [
            ImageView { image: Main.makeImage("fondo1.jpg")} ,
            MediaView
            {
                fitWidth: bind 300
                fitHeight: bind 300
                layoutX:1000
                layoutY:30

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
