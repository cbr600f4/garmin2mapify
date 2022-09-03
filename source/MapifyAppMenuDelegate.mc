import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class MapifyAppMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
        System.println("BUTTON -> Clicked the menu button");
    }

    function onMenuItem(item as Symbol) as Void {

        if (item == :item_manual_mode) {
            System.println("MENU -> Manual mode selected");
        } else if (item == :item_automatic_mode) {
            System.println("MENU -> Automatic mode selected");
        }
    }

}