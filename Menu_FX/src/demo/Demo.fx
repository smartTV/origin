/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package demo;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import displayshelf.Slider;

/**
 * @author Spook
 */

Stage {
    title: "Application title"
    scene: Scene {
        width: 600
        height: 600
        content: [
            Text {
                font: Font {
                    size: 16
                }
                x: 0
                y: 0
                content: "Application content"
            },
            Slider{}
        ]
    }
}