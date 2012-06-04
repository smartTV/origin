package Menus;

import javafx.scene.*;
import javafx.scene.image.*;
import javafx.scene.input.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.layout.Container;

def APP_PADDING = 4;
def PADDING = 5 ;

public class ScenarioButton extends Container {
    public-init var index: Integer;
    public-init var thumbIcon: Image;
    var active = bind (index == Menus.Main.currentIndex);
    public def SIZE = 40*Menus.Main.S;
    init{
        children = [
            Rectangle {
                width: SIZE
                height: SIZE
                arcWidth: SIZE / APP_PADDING
                arcHeight: SIZE / APP_PADDING
                fill: null
                stroke: bind if (active) then Color.YELLOW else Color.MEDIUMBLUE
                strokeWidth: 4
             },
             Rectangle {
                 width: SIZE
                 height: SIZE
                 arcWidth: SIZE / APP_PADDING
                 arcHeight: SIZE / APP_PADDING
                 fill: RadialGradient {
                     centerX: 0.5
                     centerY: 0.5
                     stops: [
                         Stop { offset: 0.0 color: Color.DARKBLUE },
                         Stop { offset: 0.8 color: Color.BLACK }
                     ]
                 }
                 onMousePressed: function(e: MouseEvent) {
                     Menus.Main.currentIndex = index;
                 }
             },
             ImageView {
                 x: (SIZE - thumbIcon.width) / PADDING+5
                 y: (SIZE - thumbIcon.height) / PADDING+5
                 image: thumbIcon

             }
        ]
    }
}
