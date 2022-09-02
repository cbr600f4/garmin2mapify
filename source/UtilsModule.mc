import Toybox.System;
import Toybox.Application;
import Toybox.Lang;
import Toybox.Position;

module Utils {

    // Reads and validates a numeric value from the App Settings
    function readKeyNumber(myApp as Application.AppBase, key as Lang.String, defaultValue as Lang.Number) as Lang.Number {
        var value = myApp.getProperty(key);
        if(value == null || !(value instanceof Lang.Number)) {
            if(value == null) {
                value = defaultValue;
            }
        }
        return value;
    }

    // Reads and validates a string value from the App Settings
    function readKeyString(myApp as Application.AppBase, key as Lang.String, defaultValue as Lang.String) as Lang.String {
        var value = myApp.getProperty(key);

        if(value == null || !(value instanceof Lang.String)) {
            if(value != null) {
                value = value.toString();
            } else {
                value = defaultValue;
            }
        }

        return value;
    }

    public function positionToJsonString(info as Info) as String {

        var positionString = "";
        positionString = "{";

        var position = info.position;
        if (position != null) {
            positionString += "\\\"lat\\\": " + position.toDegrees()[0].toString();
            positionString += ",\\\"lon\\\": " + position.toDegrees()[1].toString();
        }

        var speed = info.speed;
        if (speed != null) {
            positionString += ",\\\"speed\\\": " + speed.toString();
        }

        var altitude = info.altitude;
        if (altitude != null) {
            positionString += ",\\\"alt\\\": " + altitude.toString();
        }

        var heading = info.heading;
        if (heading != null) {
            positionString += ",\\\"heading\\\": " + heading.toString();
        }

        var accuracy = info.accuracy;
        if (accuracy != null) {
            positionString += ",\\\"accuracy\\\": " + accuracy.toString();
        }

        var timestamp = info.when;
        if (timestamp != null) {
            positionString += ",\\\"timestamp\\\": " + timestamp.value();
        }

        positionString += "}";

        System.println(positionString);

        return positionString;
    }

}