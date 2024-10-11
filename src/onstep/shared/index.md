# OnStep Conversion Details


## TO DO: decide on V_in and Voltage regulation.


The following information pertains to the OnStep conversion of both
the Losmandy G11 and Celestron EQ5 mounts.


## The Firmware: OnStepX

The heart of OnStep is the firmware.  As the OnStep project matured, a
bottom-up re-write of the firmware called **OnStepX** was released.
This is the firmware we use.  Don't confuse it with the older
firmware, called simply OnStep.

For the purposes of configuring and building OnStepX for our telescope
mounts, I made a fork of the OnStepX github repository.  That repo can
be found [HERE](https://github.com/jsteele22/OnStepX), and should be
consulted for any further firmware details.

## The Controller: MaxPCB4

The firmware must run on a *dedicated* microcontroller which can
directly control the motors on the mount.  So the other heart of
OnStep is a **controller board** which at minimum provides a
microcontroller, at least two motor drivers, and some means of
communication with the user.

There are many different controller boards available which meet these
requirements.  The one we use is the **MaxPCB4**.  This board was
designed specifically for the OnStep project and it only runs the
OnStepX firmware.

Some public information about the MaxPCB4:

* [General information ](http://onstep.groups.io/g/main/wiki/33523)

* [PCB design](http://oshwlab.com/hdutton/maxpcb4/)

* [Kits for sale here](http://graydigitalarts.com/product/maxpcb4)


# Controller Hardware Options

There are various hardware options when assembling the MaxPCB4
controller.  Below are the *hardware* configuration we currently have.
For firmware configuration options, see the github repository
referenced above.

* PCB version : MaxPCB4.01

* Microcontroller module: Teensy 4.1

* Battery backup option: installed.

* Power switch: no

* Axes 1 and 2 (Ra, Dec) motor controllers : TMC2130 v3.0 modules
  purchased from from vendor BIQU on Amazon. These are SPI
  controllers.

* Axes 1 and 2 jumpers: set for SPI mode

* Axes 1 and 2 (RA, Dec) output connector: RJ45.

* Axes 3 and 4 motor controller: not installed (yet)

* Axes 3 and 4 jumpers: not populated.

* Axes 3 and 4 output connector: RJ22 (6P6C modular jack.)

* Axes 3 and 4 voltage: same as Axes 1 and 2.

* DB15 auxilliary connector:  not populated.

* ST4 interface: RJ12 socket installed, +5V jumper **not** installed.

* WeMos D1 socket : ESP8266 WeMos Mini Pro (provides WiFi, no
  Bluetooth.) Currently running the OnStep Smart Web Server (SWS)

* Buzzer: not installed. (requires *active* piezo buzzer.)


## Potential Hardware Configuration Changes:

* Use Axis 3 (or 4) to control focuser on Lunt solar telescope.

* Install an active buzzer.

* Replace Wemos module with WeMos ESP32 D1 Mini, to provide Bluetooth
  capability.

