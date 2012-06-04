package Menus;

import javafx.animation.Interpolator;
import javafx.animation.transition.FadeTransition;
import javafx.scene.layout.Container;

    public abstract class Scenario extends Container
    {
        var fadein = FadeTransition
        {
            node: this
            fromValue: bind this.opacity
            toValue: 1
            duration: 2s
            interpolator: Interpolator.EASEOUT
        };

        var fadeout = FadeTransition
        {
            node: this
            fromValue: bind this.opacity
            toValue: 0
            duration: 2s
            interpolator: Interpolator.EASEOUT
        };

        public var running: Boolean on replace
        {
            if (running) then play() else pause();
        }

        protected abstract function play(): Void;
        protected abstract function pause(): Void;

        public function fadeIn()
        {
            if (running) then play();
            fadeout.stop();
            fadein.play();
        }

        public function fadeOut()
        {
            fadein.stop();
            fadeout.play();
            pause();
        }
}
