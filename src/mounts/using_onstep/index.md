# Using OnStep

## Why are you here?

Do you **need** to know anything about OnStep?

Our two OnStep telescope mounts are configured to begin tracking at
sidereal rate as soon as they are powered on.  If you don't plan to
use any smart telescope features like software star alignment or
finding a target, then you cn skip the rest and start observing.

Just point the telescope at an object.  If you were precise enough
while setting up the mount, the object should remain in view for a
while.

For everyone else, keep reading.

## Background

The most basic functions of the OnStep controller attached to the
telescope are:

* **Star Alignment:** gathering data on where the stars *really* are,
  and using this data to correct for imperfect mount alignment or
  configuration inputs.

* Keeping track of the telescope's position as it moves.

* Moving the scope, either in response to user input or to track
  objects as they move across the sky.

* Communication, whether it be with other electronics, a computer
  program, or even a human.


There are *many, many* ways to access and use OnStep.  Here we will
present a limited range of options to keep things manageable. Even so,
it helps to scan the material first to get a broad overview and then
decide where to focus for more detail.

Broadly speaking, you can connect to the telescope (i.e., the OnStep
controller) in two different modes.  This is not official OnStep
terminology, just a distinction that helps organize your approach to
using Onstep.

* **User Mode**, where a generic program (e.g., Stellarium) talks to
  the scope, but with limited features. This could even include
  simplistic use cases like a passive hand controller.

* **Control Mode**, where an OnStep-specific program has full control
  of (nearly) every possible feature.

Example: Stellarium is a great *user mode* program.  In addition to
its planetarium features, it can control and display the scope's
position and send data to the scope to update its star alignment.
This is almost all you need for a night of observing.  But Stellarium
cannot, for example, turn tracking on/off, switch to solar tracking,
park the telescope, change the slew rate, verify or change the time,
etc.  For that you will need a *Control Mode* program.

Note: It is fine to use different devices for control mode and user
mode access; e.g, an Android phone for control and a laptop for a user
program.  It is fine if both devices are connected simultaneously, but
they don't have to be; you could adjust a few settings from your phone
and then disconnect, then fire up software on your laptop for the rest
of the evening.

## Prerequisites (all use cases):

* The mount is set up and mechanically aligned.

* The OTA is installed and balanced.

* With **power off**, the scope is placed (precisely!) in **Home
  Position**.

## Power Up

Now, power on the controller.  There is no switch, just plug in the
power cable.

From now on, **do not move the scope manually** (i.e., by loosening
the clutches and pushing).  This would confuse the controller.

If anything goes wrong (power glitch, someone moves the cope manually)
just go back to Home position and do a power cycle.

## Establish Control Mode Access.

Choose one of the [options for Control Mode Access](control_mode.md)

## Are You Through Yet?

You might be ready to start observing.  There are a few options for
controlling the telescope without any additional software.

* You can just slew to objects you see in the sky.  For the slewing
  controls, you can use the web interface, the Android app, or a
  passive hand controller. (Check for hand controller directions
  before pluging anything in!)

* You can just enter coordinates for objects you want to observe using
  the web interface or the Android app. When you are centered on an
  object, you can update the star alignment.

* You can choose objects from a catalog in the Android app.  (The web
  interface also has this feature, but it needs updating to work.)

* A smart hand controller could be an option.  We don't have one yet,
  but stay tuned.

For anything more than the (not very polished) solutions above, you'll
probably want to use some user-friendly software.


## Prepare OnStep for User Mode Software.

Learn about [how user mode software talks to OnStep.](user_mode.md)
There may or may not be some steps you need to take.

