package Menus;
import javafx.scene.*;
import javafx.scene.image.*;
import javafx.scene.media.MediaPlayer;
import javafx.scene.media.Media;
import javafx.scene.media.MediaView;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import calendar.Calendario;

def S = Main.S;
def PADDING = 2;
def track_strokeWidth = 20 * S;
def line_strokewidth = 2;
package def THUMB_ICON = Main.makeImage("home.png");

package class Home extends Scenario
{
     def path=
     [
         Rectangle
         {
             height:60
             width:300
             layoutX:144
             layoutY:625
             
            fill: LinearGradient
            {
              stops:
              [
                 Stop
                 {
                    //color: Color.TEAL
                    color: Color.TRANSPARENT
                 }
              ]
            }
         }
       ];
      
      
    init
    {
        children =
        [
            ImageView { image: Main.makeImage("blue.jpg") },
            Calendario{layoutX:1040
            layoutY:330},
           path,Clock1{layoutX:950
            layoutY:205},

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
                      source:"http://projavafx.com/movies/elephants-dream-640x352.flv"
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
