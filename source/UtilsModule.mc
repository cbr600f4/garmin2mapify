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

        return positionString;
    }


    public function composeJsonMessage(info as Info) as String{
        
        var message = "";
        message = "{";


        // --- Device System ---
        var myDevice = System.getDeviceSettings();
        if(myDevice != null) {

            if (myDevice.uniqueIdentifier != null) {
                var uniqueIdentifier = myDevice.uniqueIdentifier;
                if(uniqueIdentifier != null) {
                    message += "\\\"uniqueIdentifier\\\": \\\"" + uniqueIdentifier.toString() + "\\\"";
                }
                else {
                    System.println("Utils.composeMessage -> ERROR: Device unique identifier not available.");
                    throw new Exception();
                }
            }
            
            if (myDevice.firmwareVersion != null) {
                var firmwareVersion = myDevice.firmwareVersion;
                message += ",\\\"firmwareVersion\\\": " + firmwareVersion.toString();
            }
            
            if (myDevice.isTouchScreen != null) {
                var isTouchScreen = myDevice.isTouchScreen;
                message += ",\\\"isTouchScreen\\\": " + isTouchScreen.toString();
            }
            
            if (myDevice.partNumber != null) {
                var partNumber = myDevice.partNumber;
                message += ",\\\"partNumber\\\": \\\"" + partNumber.toString() + "\\\"";
            }
            
            if (myDevice.screenHeight != null) {
                var screenHeight = myDevice.screenHeight;
                message += ",\\\"screenHeight\\\": " + screenHeight.toString();
            }
            
            if (myDevice.screenWidth != null) {
                var screenWidth = myDevice.screenWidth;
                message += ",\\\"screenWidth\\\": " + screenWidth.toString();
            }
            
            if (myDevice.screenShape != null) {
                var screenShape = myDevice.screenShape;
                message += ",\\\"screenShape\\\": " + screenShape.toString();
            }
            
            if (myDevice.systemLanguage != null) {
                var language = myDevice.systemLanguage;
                message += ",\\\"language\\\": " + language.toString();
            }

        }
        else {
            System.println("Utils.composeMessage -> ERROR: Device settings not available.");
            throw new Exception();
        }


        // --- Device Stats ---
        var myStats = System.getSystemStats();
        if(myStats != null) {
            
            if (myStats.battery != null) {
                var battery = myStats.battery;
                message += ",\\\"battery\\\": " + battery.toString();
            }

            // »»»»» Only available in API >4.1 ««««     
            // if (myStats.batteryInDays != null) {
            //     var batteryInDays = myStats.batteryInDays;
            //     if(batteryInDays != null) {
            //         message += ",\\\"batteryInDays\\\": " + batteryInDays.toString();
            //     }
            // }
            
            if (myStats.charging != null) {
                var charging = myStats.charging;
                message += ",\\\"charging\\\": " + charging.toString();
            }
            
            // »»»»» Only available in API >4.1 ««««  
            // if (myStats.solarIntensity != null) {
            //     var solarIntensity = myStats.solarIntensity;
            //     if(solarIntensity != null) {
            //         message += ",\\\"solarIntensity\\\": " + solarIntensity.toString();
            //     }
            // }
            
            if (myStats.freeMemory != null) {
                var freeMemory = myStats.freeMemory;
                message += ",\\\"freeMemory\\\": " + freeMemory.toString();
            }
            
            if (myStats.usedMemory != null) {
                var usedMemory = myStats.usedMemory;
                message += ",\\\"usedMemory\\\": " + usedMemory.toString();
            }
            
            if (myStats.totalMemory != null) {
                var totalMemory = myStats.totalMemory;
                message += ",\\\"totalMemory\\\": " + totalMemory.toString();
            }
        }
        else {
            System.println("Utils.composeMessage -> ERROR: Device system stats not available.");
            throw new Exception();
        }


        // --- Device location ---
        var position = info.position;
        if (position != null) {
            message += ",\\\"lat\\\": " + position.toDegrees()[0].toString();
            message += ",\\\"lon\\\": " + position.toDegrees()[1].toString();
        }

        var speed = info.speed;
        if (speed != null) {
            message += ",\\\"speed\\\": " + speed.toString();
        }

        var altitude = info.altitude;
        if (altitude != null) {
            message += ",\\\"alt\\\": " + altitude.toString();
        }

        var heading = info.heading;
        if (heading != null) {
            message += ",\\\"heading\\\": " + heading.toString();
        }

        var accuracy = info.accuracy;
        if (accuracy != null) {
            message += ",\\\"accuracy\\\": " + accuracy.toString();
        }

        var timestamp = info.when;
        if (timestamp != null) {
            message += ",\\\"timestamp\\\": " + timestamp.value();
        }

        message += "}";

        return message;

    }


}