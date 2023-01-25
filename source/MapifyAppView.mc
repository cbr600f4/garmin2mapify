import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Position;
import Toybox.Application;
import Toybox.Application.Storage;
import Toybox.Timer;
using Utils;

class MapifyAppView extends WatchUi.View {

    private var _message as String = "Press the select button";
    private var _lines as Array<String>;
    private var _publishMode as String;                 // The position publishing mode (automatic or manual)
    private var _publishTimer as Timer.Timer?;          // Timer used in automatic publishing mode
    private var _positionsCount as Number;              // Total positions published
    private const AUTO_SEND_INTERVAL as Number = 5;     // Default number of seconds between sending data in automatic mode

    function initialize() {
        View.initialize();

        // Initial value shown until we have position data
        _lines = ["No position info"] as Array<String>;

        // Read position publish mode from storage (default = "MANUAL")
        var publishMode = Storage.getValue("publish_mode");
        if (publishMode instanceof String) {
            _publishMode = publishMode;
        } else {
            _publishMode = "MANUAL";
        }

        _positionsCount = 0;

        System.println("Publish mode: " + _publishMode);
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MapifyLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        System.println("MAPIFYAPPVIEW -> Displaying main view");
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {        

         // Read position publish mode from storage and update UI
        var publishMode = Storage.getValue("publish_mode");
        if (publishMode instanceof String) {
            _publishMode = publishMode;
        } else {
            _publishMode = "MANUAL";
        }
        updateLabel("label_app_mode", _publishMode + " mode active");

        var env = Utils.readKeyNumber(Application.AppBase, "MapifyEnvironment", 1);
        Mapify.setEnvironment(env);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }


    //! Show the result or status of the web request
    //! @param args Data from the web request, or error message
    public function onReceive(args as Dictionary or String or Null) as Void {
        if (args instanceof String) {
            _message = args;
            System.println("Response: " + _message);
        } else if (args instanceof Dictionary) {
            // Print the arguments duplicated and returned by jsonplaceholder.typicode.com
            var keys = args.keys();
            _message = "";
            for (var i = 0; i < keys.size(); i++) {
                _message += Lang.format("$1$: $2$\n", [keys[i], args[keys[i]]]);
            }
        }
        WatchUi.requestUpdate();
    }

    //! Set the position
    //! @param info Position information
    public function setPosition(info as Info) as Void {
        _lines = [] as Array<String>;

        var position = info.position;
        if (position != null) {
            _lines.add("lat = " + position.toDegrees()[0].toString());
            _lines.add("lon = " + position.toDegrees()[1].toString());
        }

        var speed = info.speed;
        if (speed != null) {
            _lines.add("speed = " + speed.toString());
        }

        var altitude = info.altitude;
        if (altitude != null) {
            _lines.add("alt = " + altitude.toString());
        }

        var heading = info.heading;
        if (heading != null) {
            _lines.add("heading = " + heading.toString());
        }

        // DEBUG
        // for (var i = 0; i < _lines.size(); ++i) {
        //     System.println(_lines[i]);
        // }
    }


    //! Update a label in the view with new text
    //! @param labelId The label to update
    //! @param labelText The text for the label
    private function updateLabel(labelId as String, labelText as String) as Void {
        var drawable = View.findDrawableById(labelId);
        if (drawable != null) {
            (drawable as Text).setText(labelText);
        }
    }

    // Callback for the automated position publishing
    public function processPosition() as Void {

        System.println("AUTOMATIC -> Publishing position...");

        var position = Position.getInfo();
        // Utils.printPosition(position);

        var mapify = new Mapify.DataFeed();
        mapify.publishMessage(Utils.composeJsonPayload(position).toDictionary());

        _positionsCount++;
        WatchUi.requestUpdate();
    }

    // Start automated processing of positions
    public function startProcessingPositions() as Void{
        var positionInterval = Utils.readKeyNumber(Application.AppBase, "positionCommunicationInterval", AUTO_SEND_INTERVAL);

        var auxTimer = new Timer.Timer();
        auxTimer.start(method(:processPosition), positionInterval*1000, true);

        _publishTimer = auxTimer;
    }
    
    // Stop automated processing of positions
    public function stopProcessingPositions() as Void {
        var auxTimer = _publishTimer;
        if (auxTimer != null) {
            auxTimer.stop();
        }
    }

}
