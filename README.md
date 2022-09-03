# garmin2mapify
Extremely simple [Connect IQ](https://apps.garmin.com) app made in [Monkey C](https://developer.garmin.com/connect-iq/monkey-c/) which sends the device location to a [Mapify](https://www.mapify.ai/) data feed, just for fun and learning.

![Mapify simple Connect IQ app to send device position to a data feed](./docs/img/mapify-iq-app.png)


## Requirements

- Make sure you have a valid [Mapify account](https://www.mapify.ai).
- In your Mapify console generate an API Key with the Datafeed Messaging permission enabled and create a data feed to handle the incoming messages.
> Note: For the best initial experience you can create a Mapify Workflow which sends you an email everytime a message is received from your app.
- Download and install [Visual Studio Code](https://code.visualstudio.com/)
- Download and install the [Garmin Connect IQ SDK](https://developer.garmin.com/connect-iq/sdk/)
    - When adding devices to the SDK, be sure to include at least one of the following:
        - Edge 520 Plus
        - Enduro
        - Fenix 6
        - Fenix 6 Pro
        - Fenix 6 S
        - Fenix 6 S Pro
- Download and install the [Visual Studio Code Monkey C Extension](https://marketplace.visualstudio.com/items?itemName=garmin.monkey-c)


## Usage

### Simulator

- In Visual Studio Code, open one of the ```.mc``` files from the ```source``` folder in the editor window
- Press Ctrl-F5 to run without debugging
- Select the target device from the list of available devices shown
- In your first time running the app in the simulator, [configure your Connect IQ application settings](./docs/application-settings.md)
- In VS Code, be sure the Debug Console tab is visible (for you to see what's happening)
- In the simulator, using your mouse cursor click the device button assigned to the Select operation.
- Check the Debug Console in VS Code. Your position has been sent to the configured Mapify Data feed :-)


### Device **(Work in Progress, not available yet)**

- Install the app from the [Connect IQ Store](https://apps.garmin.com/en-US/)
- [How to Access the Settings of Downloaded Connect IQ Content Using the Garmin Connect App](https://support.garmin.com/en-US/?faq=SPo0TFvhQO04O36Y5TYRh5)