import Toybox.Communications;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Position;
using Mapify;
using Utils;

class MapifyAppDelegate extends WatchUi.BehaviorDelegate {

    function initialize(handler as Method(args as Dictionary or String or Null) as Void) {
        WatchUi.BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new MapifyAppMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onSelect() as Boolean{
        System.println("BUTTON -> Clicked the select button");

        var position = Position.getInfo();
        // Utils.printPosition(position);

        Mapify.setEnvironment(1);

        var mapify = new Mapify.DataFeed();
        mapify.publishMessage(Utils.positionToJsonString(position));
        return true;
    }
}