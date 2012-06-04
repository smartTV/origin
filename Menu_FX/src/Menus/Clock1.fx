package Menus;
/*
* Clock.fx
*
* Created on 09-02-2009, 23:45:41
*/

/**
* @author Troels
*/

import java.util.Date;
import java.util.*;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.transform.Translate;
import javafx.scene.transform.*;

import javafx.animation.Timeline;
import javafx.animation.KeyFrame;

public class Clock1 extends CustomNode {

    public var hours;
    public var minutes;
    public var seconds;
    public var time:String;

    public override function create() : Node {

        var centerX: Number = 50;
        var centerY: Number = 50;

        return Group {

            transforms: [

                Transform.translate(centerX, centerY)
            ]

            content: [

                Text
                {
                    font: Font
                    {
                        size: 60
                        name: "Calibri"
                    }
                    x: 45
                    y: 25
                
                    content: bind time
                }
            ]
        }
    }

    public function getTime() {

        var date = new Date();

        seconds = date.getSeconds();
        minutes = date.getMinutes();
        hours = date.getHours();

        time = "{hours}:{minutes}:{seconds}";

        //Ensure that the numbers are displayed in 24 mode
        if (seconds < 10)  {

            time = "{hours}:{minutes}:0{seconds}";
        }

        if (minutes < 10)  {

            time = "{hours}:0{minutes}:{seconds}";
        }

        if (hours < 10)  {

            time = "0{hours}:{minutes}:{seconds}";
        }
    }

    init {
        var timeline = Timeline
        {
            repeatCount: Timeline.INDEFINITE
            
            keyFrames:
            [
                KeyFrame
                {
                    time: 1s
                    canSkip: true
                    
                    action: function()
                    {
                        getTime();
                    }
                }
            ]
        }
        timeline.play();
    }
}