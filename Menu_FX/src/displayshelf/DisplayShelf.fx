package displayshelf;

import javafx.animation.*;
import javafx.scene.*;
import javafx.util.*;
import javafx.scene.effect.DropShadow;
import javafx.scene.shape.Rectangle;

public class DisplayShelf extends CustomNode {
    public var content:Node[];
    public-init var spacing = 110;
    public-init var leftOffset = -50;
    public-init var rightOffset = 50;
    public-init var perspective = false;
    public-init var scaleSmall = 0.5;
    
    public var itemInfo:Rectangle;
    

    var left:Group = Group { };
    var center:Group = Group { };
    var right:Group = Group { };
    public var centerIndex = 0;

    var group:Group = Group {
            content: [
                left,
                right,
                center
            ]
        };
    
    public function changeInfo(info:Rectangle):Void{
        itemInfo = info;
    }

    override public function create():Node {
        var half = content.size()/2-1;

        if(half == -1){
            half = 0;
        }


        println("content size/2: {half}");

        left.content =  content[0..half-2];
        center.content = content[half-1];
        center.effect = DropShadow {};
        right.content = content[half..content.size()-1];
        right.content = Sequences.<<reverse>>(right.content) as Node[];
        centerIndex = half-1;
        myLayout();
        return group
    }

    public function refresh(){
        var half;
        if(content.size() == 0){
            half = 0;
            println("0000content size/2: {half}");

            left.content =  null;
            center.content = null;
            right.content = null;
            centerIndex = half;
        }else if(content.size() == 1){
            half = 0;
            println("1111content size/2: {half}");
            
            left.content =  null;
            center.content = content[0];
            right.content = null;
            centerIndex = half;
        }else if(content.size() == 2){
            half = 1;
            println("2222content size/2: {half}");

            left.content =  content[half-1];
            center.content = content[half];
            right.content = null;
            centerIndex = half;
        }else if(content.size() == 3){
            half = content.size()/2;
            println("3333content size/2: {half}");

            left.content =  content[0..half-1];
            center.content = content[half];
            right.content = content[half+1..content.size()-1];
            right.content = Sequences.<<reverse>>(right.content) as Node[];
            centerIndex = half;

        }else if(content.size() > 3){
            half = content.size()/2;
            println(">>33content size/2: {half}");

            left.content =  content[0..half-2];
            center.content = content[half-1];
            right.content = content[half..content.size()-1];
            right.content = Sequences.<<reverse>>(right.content) as Node[];
            centerIndex = half-1;

        }

        myLayout();
    }



    /**
     * "Reparents" the node sequence newContent to its new parent Group
     * newParent, replacing any previous content,
     * after first removing them from their previous parent Group.
     */
    public function reparent(newContent:Node[], newParent:Group):Void {
        for (n in newContent) {
            if (n.parent instanceof Group) {
                delete n from (n.parent as Group).content;
            }
        }
        newParent.content = newContent;
    }

    public function shift(offset:Integer):Void {
        if(centerIndex <= 0 and offset > 0 ) {
            return;
        }
        if(centerIndex >= content.size()-1 and offset < 0) {
            return;
        }

        centerIndex -= offset;
        reparent(content[0..centerIndex-1], left);
        reparent([content[centerIndex]], center);
        reparent(Sequences.<<reverse>>(content[centerIndex+1..content.size()-1]) as Node[], right);
        myLayout();
    }

    function myLayout() {
        var startKeyframes:KeyFrame[];
        var endKeyframes:KeyFrame[];
        var duration = 0.5s;

        for(n in content) {
            def it = n as Item;
            insert KeyFrame {
                time: 0s values: [
                    it.translateX => it.translateX,
                    it.scaleX => it.scaleX,
                    it.scaleY => it.scaleY,
                    it.angle => it.angle
                ]
            } into startKeyframes;
        }

        for(n in left.content) {
            def it = n as Item;
            var newX = -left.content.size()*spacing +  spacing*indexof n + leftOffset;
            insert KeyFrame {
                time: duration values: [
                    it.translateX => newX,
                    it.scaleX => scaleSmall,
                    it.scaleY => scaleSmall,
                    it.angle => 45
                ]
            } into endKeyframes;
        }

        for(n in center.content) {
            def it = n as Item;
            insert KeyFrame {
                time: duration values: [
                    it.translateX => 0,
                    it.scaleX => 1.0,
                    it.scaleY => 1.0,
                    it.angle => 90
                ]
            } into endKeyframes;
        }

        for(n in right.content) {
            def it = n as Item;
            var newX = right.content.size()*spacing -spacing*indexof n + rightOffset;
            insert KeyFrame {
                time: duration values: [
                    it.translateX => newX,
                    it.scaleX => scaleSmall,
                    it.scaleY => scaleSmall,
                    it.angle => 135
                ]
            } into endKeyframes;
        }

        var anim = Timeline {
            keyFrames: [
                startKeyframes,
                endKeyframes
            ]
        };
        anim.play();
    }

    public function shiftToCenter(item:Item):Void {
        for(n in left.content) {
            if(n == item) {
                println("left");
                var index = indexof n;
                var shiftAmount = left.content.size() - index;
                shift(shiftAmount);
                return;
            }
        }
        for(n in center.content) {
            if(n == item) {
                println("center");
                return;
            }
        }
        for(n in right.content) {
            if(n == item) {
                println("right");
                var index = indexof n;
                var shiftAmount = -(right.content.size() - index);
                shift(shiftAmount);
                return;
            }
        }
    }
}
