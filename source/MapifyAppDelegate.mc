import Toybox.Communications;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Position;
using Mapify;
using Utils;

class MapifyAppDelegate extends WatchUi.BehaviorDelegate {

    // function initialize(handler as Method(args as Dictionary or String or Null) as Void) {
    //     WatchUi.BehaviorDelegate.initialize();
    // }
    var _view as MapifyAppView;

    function initialize(view as MapifyAppView) {
        _view = view;
        WatchUi.BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new MapifyAppMenuDelegate(_view), WatchUi.SLIDE_UP);
        return true;
    }

    function onSelect() as Boolean{
        System.println("BUTTON -> Clicked the select button");

        var position = Position.getInfo();
        // Utils.printPosition(position);

        var env = Utils.readKeyNumber(Application.AppBase, "MapifyEnvironment", 1);
        Mapify.setEnvironment(env);

        var mapify = new Mapify.DataFeed();
        mapify.publishMessage(Utils.composeJsonMessage(position));
        return true;
    }
}