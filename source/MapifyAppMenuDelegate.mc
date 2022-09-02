import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class MapifyAppMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
        System.println("Clicked the menu button");
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :item_1) {
            System.println("Selected item 1");
        } else if (item == :item_2) {
            System.println("Selected item 2");
        }
    }

}