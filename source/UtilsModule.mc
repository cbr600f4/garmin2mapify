import Toybox.System;
import Toybox.Application;
import Toybox.Lang;
import Toybox.Position;
import GarminDevice;

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
            positionString += "\"lat\": "  + position.toDegrees()[0].toString();
            positionString += ", \"lon\": "  + position.toDegrees()[1].toString();
        }

        var speed = info.speed;
        if (speed != null) {
            positionString += ", \"speed\": "   + speed.toString();
        }

        var altitude = info.altitude;
        if (altitude != null) {
            positionString += ", \"alt\": "   + altitude.toString();
        }

        var heading = info.heading;
        if (heading != null) {
            positionString += ", \"heading\": " + heading.toString();
        }

        var accuracy = info.accuracy;
        if (accuracy != null) {
            positionString += ", \"accuracy\": "  + accuracy.toString();
        }

        var timestamp = info.when;
        if (timestamp != null) {
            positionString += ", \"timestamp\": "  + timestamp.value();
        }

        positionString += "}";

        return positionString;
    }


    public function composeJsonMessage(info as Info) as String{

        var message = "{";

        // --- Device System ---
        var myDevice = System.getDeviceSettings();
        if(myDevice != null) {

            if (myDevice.uniqueIdentifier != null) {
                var uniqueIdentifier = myDevice.uniqueIdentifier;
                if(uniqueIdentifier != null) {
                    message += " \"uniqueIdentifier\": \"" + uniqueIdentifier.toString() + "\"";
                }
                else {
                    System.println("Utils.composeMessage -> ERROR: Device unique identifier not available.");
                    throw new Lang.Exception();
                }
            }
            
            if (myDevice.firmwareVersion != null) {
                var firmwareVersion = myDevice.firmwareVersion;
                message += ", \"firmwareVersion\": " + firmwareVersion.toString();
            }
            
            if (myDevice.isTouchScreen != null) {
                var isTouchScreen = myDevice.isTouchScreen;
                message += ", \"isTouchScreen\": " + isTouchScreen.toString();
            }
            
            if (myDevice.partNumber != null) {
                var partNumber = myDevice.partNumber;
                message += ", \"partNumber\": \""  + partNumber.toString() + "\"";
            }
            
            if (myDevice.screenHeight != null) {
                var screenHeight = myDevice.screenHeight;
                message += ", \"screenHeight\": "  + screenHeight.toString();
            }
            
            if (myDevice.screenWidth != null) {
                var screenWidth = myDevice.screenWidth;
                message += ", \"screenWidth\": "  + screenWidth.toString();
            }
            
            if (myDevice.screenShape != null) {
                var screenShape = myDevice.screenShape;
                message += ", \"screenShape\": "  + screenShape.toString();
            }
            
            if (myDevice.systemLanguage != null) {
                var language = myDevice.systemLanguage;
                message += ", \"language\": "  + language.toString();
            }

        }
        else {
            System.println("Utils.composeMessage -> ERROR: Device settings not available.");
            throw new Lang.Exception();
        }


        // --- Device Stats ---
        var myStats = System.getSystemStats();
        if(myStats != null) {
            
            if (myStats.battery != null) {
                var battery = myStats.battery;
                message += ", \"battery\": "  + battery.toString();
            }

            // »»»»» Only available in API >4.1 ««««     
            // if (myStats.batteryInDays != null) {
            //     var batteryInDays = myStats.batteryInDays;
            //     if(batteryInDays != null) {
            //         message += ", batteryInDays: "  + batteryInDays.toString();
            //     }
            // }
            
            if (myStats.charging != null) {
                var charging = myStats.charging;
                message += ", \"charging\": "  + charging.toString();
            }
            
            // »»»»» Only available in API >4.1 ««««  
            // if (myStats.solarIntensity != null) {
            //     var solarIntensity = myStats.solarIntensity;
            //     if(solarIntensity != null) {
            //         message += ", solarIntensity: "  + solarIntensity.toString();
            //     }
            // }
            
            if (myStats.freeMemory != null) {
                var freeMemory = myStats.freeMemory;
                message += ", \"freeMemory\": "  + freeMemory.toString();
            }
            
            if (myStats.usedMemory != null) {
                var usedMemory = myStats.usedMemory;
                message += ", \"usedMemory\": "  + usedMemory.toString();
            }
            
            if (myStats.totalMemory != null) {
                var totalMemory = myStats.totalMemory;
                message += ", \"totalMemory\": "  + totalMemory.toString();
            }
        }
        else {
            System.println("Utils.composeMessage -> ERROR: Device system stats not available.");
            throw new Lang.Exception();
        }


        // --- Device location ---
        var position = info.position;
        if (position != null) {
            message += ", \"lat\": "  + position.toDegrees()[0].toString();
            message += ", \"lon\": "  + position.toDegrees()[1].toString();
        }

        var speed = info.speed;
        if (speed != null) {
            message += ", \"speed\": "  + speed.toString();
        }

        var altitude = info.altitude;
        if (altitude != null) {
            message += ", \"alt\": "  + altitude.toString();
        }

        var heading = info.heading;
        if (heading != null) {
            message += ", \"heading\": "  + heading.toString();
        }

        var accuracy = info.accuracy;
        if (accuracy != null) {
            message += ", \"accuracy\": "  + accuracy.toString();
        }

        var timestamp = info.when;
        if (timestamp != null) {
            message += ", \"timestamp\": "  + timestamp.value();
        }

        message += "}";

        return message;

    }

    public function composeJsonPayload(info as Info) as GarminDevice.GarminDeviceInfo {          

        var result = new GarminDevice.GarminDeviceInfo();

        var myDevice = System.getDeviceSettings();
        if(myDevice != null) {
            if (myDevice.uniqueIdentifier != null) {
                var uniqueIdentifier = myDevice.uniqueIdentifier;
                if(uniqueIdentifier != null) {
                    result.uniqueIdentifier = uniqueIdentifier;
                }
                else {
                    System.println("Utils.composeMessage -> ERROR: Device unique identifier not available.");
                    throw new Lang.Exception();
                }
            }
            
            if (myDevice.firmwareVersion != null) {
                result.firmwareVersion = myDevice.firmwareVersion;
            }
            
            if (myDevice.isTouchScreen != null) {
                result.isTouchScreen = myDevice.isTouchScreen;
            }
            
            if (myDevice.partNumber != null) {
                result.partNumber = myDevice.partNumber;
            }
            
            if (myDevice.screenHeight != null) {
                result.screenHeight = myDevice.screenHeight;
            }
            
            if (myDevice.screenWidth != null) {
                result.screenWidth = myDevice.screenWidth;
            }
            
            if (myDevice.screenShape != null) {
                result.screenShape = myDevice.screenShape;
            }
            
            if (myDevice.systemLanguage != null) {
                result.systemLanguage = myDevice.systemLanguage;
            }

        }
        else {
            System.println("Utils.composeMessage -> ERROR: Device settings not available.");
            throw new Lang.Exception();
        }

        var myStats = System.getSystemStats();
        if(myStats != null) {
            
            if (myStats.battery != null) {
                result.battery = myStats.battery;
            }

            // »»»»» Only available in API >4.1 ««««     
            // if (myStats.batteryInDays != null) {
            //     result.batteryInDays = myStats.batteryInDays;
            // }
            
            if (myStats.charging != null) {
                result.charging = myStats.charging;
            }
            
            // »»»»» Only available in API >4.1 ««««  
            // if (myStats.solarIntensity != null) {
            //     result.solarIntensity = myStats.solarIntensity;
            // }
            
            if (myStats.freeMemory != null) {
                result.freeMemory = myStats.freeMemory;
            }
            
            if (myStats.usedMemory != null) {
                result.usedMemory = myStats.usedMemory;
            }
            
            if (myStats.totalMemory != null) {
                result.totalMemory = myStats.totalMemory;
            }
        }
        else {
            System.println("Utils.composeMessage -> ERROR: Device system stats not available.");
            throw new Lang.Exception();
        }

        var position = info.position;
        if (position != null) {
            result.lat = position.toDegrees()[0];
            result.lon = position.toDegrees()[1]; 
        }

        var speed = info.speed;
        if (speed != null) {
            result.speed = speed;
        }

        var altitude = info.altitude;
        if (altitude != null) {
            result.altitude =  altitude;
        }

        var heading = info.heading;
        if (heading != null) {
            result.heading = heading;
        }

        var accuracy = info.accuracy;
        if (accuracy != null) {
            result.accuracy = accuracy;
        }

        var timestamp = info.when;
        if (timestamp != null) {
            result.timestamp = timestamp.value();
        }
       
        return result;
    }


}