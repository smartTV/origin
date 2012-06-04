package Menus;

import javafx.scene.*;
import javafx.scene.image.*;
import javafx.scene.text.*;
import javafx.stage.*;
import javafx.scene.control.Label;
import java.awt.Toolkit;
import javafx.scene.effect.DropShadow;
import javafx.scene.input.MouseEvent;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.KeyCode;

// Scale that applies to the whole scene
public def S =2.0;// if (Screen.primary.bounds.height < 450) then 1.0 else 2.0;
public var scene: Scene;

def P = if (S == 1.0) then "small" else "large";
def PADDING = 5 ;
def STAGEWIDTH =  Toolkit.getDefaultToolkit().getScreenSize().width;
def STAGEHEIGHT = Toolkit.getDefaultToolkit().getScreenSize().height;
def SCENELAYOUTY = 30;
var labelchoose: Label;
var labelplay: Label;

public function makeImage(name: String) {
    makeImage(__DIR__, name);
}

public function makeImage(dir: String, name: String) {
    Image { url: "{dir}resources/{P}/{name}" };
}

var scenarios: Scenario[] = [ Home {} ];
def currentScenario = bind scenarios[currentIndex];
public var currentIndex = 0 on replace oldIndex
{
    if (currentIndex < 0 or currentIndex > 4)
    {
        currentIndex = oldIndex;
    }
    else
    {
        println(currentIndex);
        if (currentIndex == 1)
        {
            var s = Video {};
            insert s into scenarios;
            insert s before scene.content[0];
        }
        if (currentIndex == 2)
        {
            var s = Config {};
            insert s into scenarios;
            insert s before scene.content[1];
        }
        if (currentIndex == 3)
        {
            var s = Perifericos {};
            insert s into scenarios;
            insert s before scene.content[2];
        }
        if (currentIndex == 4)
        {
            var s = Internet {};
            insert s into scenarios;
            insert s before scene.content[3];
        }

        scenarios[oldIndex].fadeOut();
        currentScenario.fadeIn();
    }
};

 function togglePlaying()
 {
    currentScenario.running = not currentScenario.running;
 }

public function run()
{
    var keyHandler: Node;

    Stage
    {
        title: "Path Animation"
        resizable: false
    
        scene: scene = Scene
        {
            width: STAGEWIDTH
            height: STAGEHEIGHT

            var sbtn1: ScenarioButton;
            var sbtn2: ScenarioButton;
            var sbtn3: ScenarioButton;
            var sbtn4: ScenarioButton;
            var sbtn5: ScenarioButton;

            var pbtn: Node;
            def TEXTLAYOUT = 10 ;
            var font = Font { name: "Arial" size: 12*S };
        
            content:
            [
                scenarios,
                
                sbtn1 = ScenarioButton
                {
                    index: 0
                    thumbIcon: Home.THUMB_ICON
                    layoutX: 20*S
                    layoutY: SCENELAYOUTY*S
                    effect: DropShadow
                    {
                        offsetX: 10
                        offsetY: 2
                    }

                },

                sbtn2 = ScenarioButton
                {
                    index: 1
                    thumbIcon: Video.THUMB_ICON
                    layoutX: bind 30*S + sbtn2.SIZE
                    layoutY: SCENELAYOUTY*S
                     effect: DropShadow
                    {
                        offsetX: 10
                        offsetY: 2
                    }

                },

                 sbtn3 = ScenarioButton
                 {
                    index: 2
                    thumbIcon: Config.THUMB_ICON
                    layoutX: bind 80*S + sbtn3.SIZE
                    layoutY: SCENELAYOUTY*S
                     effect: DropShadow
                    {
                        offsetX: 10
                        offsetY: 2
                    }

                },

                 sbtn4 = ScenarioButton
                 {
                    index: 3
                    thumbIcon: Perifericos.THUMB_ICON
                    layoutX: bind 130*S + sbtn4.SIZE
                    layoutY: SCENELAYOUTY*S
                     effect: DropShadow
                    {
                        offsetX: 10
                        offsetY: 2
                    }

                },

                 sbtn5 = ScenarioButton
                 {
                    index: 4
                    thumbIcon: Internet.THUMB_ICON
                    layoutX: bind 180*S + sbtn5.SIZE
                    layoutY: SCENELAYOUTY*S
                     effect: DropShadow
                    {
                        offsetX: 10
                        offsetY: 2
                    }

                },
                keyHandler = pbtn = ImageView
                {
                     var playImage = makeImage("+.png");                    

                     layoutX: bind scene.width - playImage.width - 20*S
                     layoutY: SCENELAYOUTY*S+160
                     
                     onMousePressed: function(ev: MouseEvent)
                     {
                         togglePlaying();
                     }
                     
                     onKeyPressed: function(ev: KeyEvent)
                     {
                         if (ev.code == KeyCode.VK_LEFT)
                         {
                             currentIndex--;
                         } 
                         else if (ev.code == KeyCode.VK_RIGHT)
                         {
                             currentIndex++;
                         }
                         else if (ev.code == KeyCode.VK_ENTER or ev.code == KeyCode.VK_SPACE)
                         {
                                       togglePlaying();
                         }
                     }
                }
            ]
        }
    }
    keyHandler.requestFocus()
}