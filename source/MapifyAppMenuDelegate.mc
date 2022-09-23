import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Application.Storage;

class MapifyAppMenuDelegate extends WatchUi.MenuInputDelegate {

    var _view as MapifyAppView;

    function initialize(view as MapifyAppView) {
        System.println("BUTTON -> Clicked the menu button");
        _view = view; 
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {

        // Depending on the selected menu option, save the choice to application storage
        if (item == :item_manual_mode) {
            System.println("MENU -> Manual mode selected");
            Storage.setValue("publish_mode", "MANUAL");       
            _view.stopProcessingPositions();
        } else if (item == :item_automatic_mode) {
            System.println("MENU -> Automatic mode selected");
            Storage.setValue("publish_mode", "AUTO");
            _view.startProcessingPositions();
        }
    }

}