import Toybox.System;
import Toybox.Application;
import Toybox.Lang;
import Toybox.Position;

module GarminDevice {

    class GarminDeviceInfo{

        public function initialize() {
        }

        public var uniqueIdentifier as Lang.String = "";
        public var firmwareVersion as Lang.Array = [0,0];
        public var partNumber as Lang.String = "";
        public var isTouchScreen as Lang.Boolean = false;
        public var screenHeight as Lang.Number = -1;
        public var screenWidth as Lang.Number = -1;
        public var screenShape as Toybox.System.ScreenShape = Toybox.System.SCREEN_SHAPE_ROUND;    
        public var systemLanguage as Toybox.System.Language = Toybox.System.LANGUAGE_ENG;

        public var battery as Lang.Float = -1.0;
        public var batteryInDays as Lang.Float = -1.0;
        public var charging as Lang.Boolean = false;
        public var solarIntensity as Lang.Number = -1;
        public var freeMemory as Lang.Number = -1;
        public var usedMemory as Lang.Number = -1;
        public var totalMemory as Lang.Number = -1;

        public var lat as Lang.Double or Lang.Float = 0.0;
        public var lon as Lang.Double or Lang.Float= 0.0;
        public var speed as Lang.Float = -1.0;
        public var altitude as Lang.Double or Lang.Float= 0.0;
        public var heading as Lang.Float = -1.0;
        public var accuracy as Toybox.Position.Quality = Toybox.Position.QUALITY_NOT_AVAILABLE;
        public var timestamp as Lang.Number = -1;

        public function toDictionary() as Lang.Dictionary
        {
            var dict = {
                "uniqueIdentifier" => uniqueIdentifier,
                "firmwareVersion" =>  firmwareVersion,
                "partNumber" => partNumber,
                "isTouchScreen " =>  isTouchScreen,
                "screenHeight" =>  screenHeight,
                "screenWidth" => screenWidth,
                "screenShape" =>  screenShape,    
                "systemLanguage" =>  systemLanguage,

                "battery" =>  battery,
                "batteryInDays" =>  batteryInDays,
                "charging" =>  charging,
                "solarIntensity" =>  solarIntensity,
                "freeMemory" =>  freeMemory,
                "usedMemory" =>  usedMemory,
                "totalMemory" =>  totalMemory,

                "lat" =>  lat,
                "lon" =>  lon,
                "speed" =>  speed,
                "altitude" => altitude,
                "heading" =>  heading,
                "accuracy" => accuracy,
                "timestamp" =>  timestamp,
            };

            return dict;
        }

    }

}