import Toybox.System;
import Toybox.Application;
import Toybox.Communications;
import Toybox.Lang;
using Utils;
using GarminDevice;

module Mapify {

    // Sets the target Mapify environment based on the respective setting in the user's Garmin Connect application.
    var mapifyEnvironment as Number = Utils.readKeyNumber(Application.AppBase, "MapifyEnvironment", 1);
    function setEnvironment(environment as Number) as Void {
        if(environment >= 0 && environment <= 2){
            mapifyEnvironment = environment;
        } else {
            System.println("Invalid environment value provided:" + environment);
            mapifyEnvironment = Utils.readKeyNumber(Application.AppBase, "MapifyEnvironment", 1);
        }
    }

    // Sets the Mapify API key to be used for Mapify API invocations, based on the respective setting in the user's Garmin Connect application.
    var mapifyApiKey as String = Utils.readKeyString(Application.AppBase, "MapifyApiKey", "");
    function setApiKey(apiKey as String) as Void {
        if(apiKey.length != 0){
            mapifyApiKey = apiKey;
        } else {
            System.println("Empty API key value provided. API key must be a valid Mapify API key.");
            mapifyApiKey = Utils.readKeyString(Application.AppBase, "MapifyApiKey", "");
        }
    }

    // Sets the Mapify Data Feed name to which messages will be sent, based on the respective setting in the user's Garmin Connect application.
    var mapifyDatafeed as String = Utils.readKeyString(Application.AppBase, "MapifyDatafeed", "");
    function setDatafeed(datafeed as String) as Void {
        if(datafeed.length != 0){
            mapifyDatafeed = datafeed;
        } else {
            System.println("Empty data feed value provided. Data feed must be an existing and valid data feed name.");
            mapifyDatafeed = Utils.readKeyString(Application.AppBase, "MapifyDatafeed", "");
        }
    }

    // Sets the number of seconds between sending device location messages to Mapify in Auto Mode, based on the respective setting in the user's Garmin Connect application.
    var positionCommunicationInterval as Number = Utils.readKeyNumber(Application.AppBase, "positionCommunicationInterval", 1);
    function setPositionCommunicationInterval(positionInterval as Number) as Void {
        if(positionInterval > 0 && positionInterval <= 3600){
            positionCommunicationInterval = positionInterval;
        } else {
            System.println("Invalid position communication interval value provided:" + positionInterval + " - Value must be between 1 and 3600 seconds.");
            positionCommunicationInterval = Utils.readKeyNumber(Application.AppBase, "positionCommunicationInterval", 1);
        }
    }

    // Represents a Mapify Data Feed, and exposes the ability to publish messages to that data feed.
    // Expects the data feed name and Mapify api key to be configured by the userin the application 
    // settings in the Garmin Connect application.
    class DataFeed {

        function initialize(){
        }

        function publishMessage(message as Lang.Dictionary) as Void {

            var url = "";

            switch(mapifyEnvironment){
                case 0:
                    url = "https://api-dev.mapify.ai/datafeeds/asyncPublish";
                    break;
                case 1:
                    url = "https://api-qa.mapify.ai/datafeeds/asyncPublish";
                    break;
                case 2:
                    url = "https://api.mapify.ai/datafeeds/asyncPublish";
                    break;
                default:
                    throw new MapifyException("Invalid Mapify environment specified");
            }               

            var envelope = {
                "datafeedName" => mapifyDatafeed,
                "message" => message
            };

            var options = {
                :method => Communications.HTTP_REQUEST_METHOD_POST,
                :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
                :headers => {
                    "Accept" => "*/" + "*",
                    "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON,   //REQUEST_CONTENT_TYPE_URL_ENCODED,
                    "Map-Api-Key" => mapifyApiKey
                }
            };

            var logMsg = "Publishing message to data feed [" + mapifyDatafeed + "] (" + mapifyEnvironment + "):";
            System.println(logMsg);
            System.println(envelope);

            Communications.makeWebRequest(
                url,
                envelope,
                options,
                method(:onReceive)
            );
        } // publishMessage

       
        //! Receive the data from the web request
        //! @param responseCode The server response code
        //! @param data Content from a successful request
        function onReceive(responseCode as Number, data as Dictionary?) as Void {

            var msg = "Message published successfully!";
            if (responseCode != 200 && responseCode != 201 && responseCode != -400) {  
                msg = "HTTP Response -> ERROR " + responseCode.toString();
            }
            else if (responseCode == -400){
                msg = "HTTP Response -> WARNING " + responseCode.toString();
            }
            System.println(msg);
            
        }


    } // class DataFeed


    // Simple exception for errors somewhat related to Mapify functionalities
    class MapifyException extends Lang.Exception {
        
        var msg as String = "Unknown Mapify related exception";

        function initialize(errorMessage as String) {
            msg = errorMessage;
            Exception.initialize();
        }

        function getErrorMessage() {
            return msg;
        }
    }


} // module