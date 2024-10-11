# OnStep Control Mode

This section presents a few different ways of achieving "Control
Mode"; i.e, full access to the OnStep controller on the scope.


## Option 0:  No Control Mode Access

You *might* be able to get by without having to change any
parameters. If this works for you, it is certainly the easiest
option. But it is best to know how to achieve control mode, just in
case.

Some possibly helpful notes:

* When the OnStep is powered up, the scope begins tracking at sidereal
  rate.  With most user mode software, you will not be able to disable
  tracking or change the rate.

* If you want the scope to do anything "smart", like knowing where it
  is pointing, it must have **very** accurate values for Local
  Standard Time (LST), Latitude, and Longitude.  With most user mode
  software, you will not be able to change or even verify the the
  controller's values for these parameters. Keep this in mind if the
  scope acts strangely...

* Other issues might come up.  Watch this space.

## Option 1: WiFi + Web Interface

This is the most flexible approach. In theory, it even works with
Apple devices.

Note: In this mode, your device will not have WiFi access to the
Internet

* Disconnect your device from any other WiFi hotspot you may be
  connected to.

* Search for the appropriate WiFi hotspot; e.g. "ONSTEP Celestron".

* Connect to this hotspot.

  * If prompted  for a password, use "password" (no quotes).

  * If your Android phone complains about "no Internet access", be
    sure to select "connect anyway" to get rid of the message.  OnStep
    may not work if you don't.

* Open a web browser and go to this URL: **http://192.168.0.1**

* You should now see a web page with lots of options.

## Option 2: Wifi + Android App

If you are using an Android phone, this option is much better. When it
works.

Note: In this mode, your device will not have WiFi access to the Internet

* Install the **OnStep Android app** from the Play Store.

* Connect to the appropriate WiFi hotspot, as above.

* Open the app.

* From the "three dots" menu (upper right), select **Connection**.

* Ignore the Bluetooth stuff, and in the bottom line enter the IP
  address and port; this should be **192.168.0.1:9999**.

* Click "Accept".

* The app should now be "live"; i.e., connected to the scope.

## Option 3: Bluetooth + Android App

Our scopes do not have Bluetooth.  Yet.  Android users, stay tuned....

