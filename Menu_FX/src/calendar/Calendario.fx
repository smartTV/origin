package calendar;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.stage.Stage;
import javafx.stage.StageStyle;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.transform.Transform;
import calendar.view.FXCalendar;
import calendar.theme.Theme;
import calendar.theme.GrayTheme;

public class Calendario extends CustomNode
{
    var stageDragInitialX:Number;
    var stageDragInitialY:Number;

    var bgColor = Color.TRANSPARENT;
    var fxCalendar = FXCalendar
    {
        theme: Theme { };
    };


    var dragBar : Rectangle = Rectangle {
        width: fxCalendar.width
        height: 40
        fill: Color.TRANSPARENT
        visible: bind ("{__PROFILE__}" != "browser")
        
 
}
    init
    {
      

        fxCalendar.requestFocus();
    }

    override public function create(): Node
    {
         return Group
         {
             content: [ dragBar, fxCalendar ]
         };
    }


}


