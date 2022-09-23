import Toybox.Application;
import Toybox.Application.Storage;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Position;
import Toybox.System;

class MapifyApp extends Application.AppBase {

    private var _mapifyView as MapifyAppView;

    function initialize() {
        AppBase.initialize();

        _mapifyView = new MapifyAppView();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
        System.println("STARTED location events");
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPosition));
        System.println("STOPPED location events");
    }

    //! Update the current position
    //! @param info Position information
    public function onPosition(info as Info) as Void {
        _mapifyView.setPosition(info);
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        var delegate = new $.MapifyAppDelegate(_mapifyView);
        return [ _mapifyView, delegate ] as Array<Views or InputDelegates>;
    }

}

function getApp() as MapifyApp {
    return Application.getApp() as MapifyApp;
}