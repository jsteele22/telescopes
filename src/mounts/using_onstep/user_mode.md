# User Mode Software: Connecting to OnStep

To connect user mode software to OnStep, there are two choices to be
made:

## Hardware Connection : USB or WiFi

You have already seen how to connect to OnStep using WiFi.  You can
just use that method if it works for you.

But for User Mode connections, there is a new, much simpler option:
Just use a USB cable.  In my experience, this is by far the simplest
and most reliable method.

The USB connection works for Window, Linux, and Mac. For your OS, be
sure you know how to identify the connection after the cable is pluged
in.


## Software Connection : Direct, ASCOM, (INDI/INDIGO ?)

### Direct Serial Connection

If you are using a USB cable, then the OnStep controller acts just
like a Meade LX200 telescope.  This is an old, very popular telescope
and many user programs (including Stellarium) know how to talk
directly to it.

If you are using a Mac, this is the option for you.

### Using ASCOM

ASCOM is a software platform (**for Windows only**) that makes
astronomy programs work together.  Any user program (like Stellarium)
that supports ASCOM, will work with any instrument that supports
ASCOM; this includes not only our OnStep mounts, but also our
Skywatcher EQ6-R Pro mount, and other goodies as well (focusers,
cameras, ...)

With OnStep, ASCOM provides access to many more features, meaning less
need to mess around with control mode software.

If you plan to use your Windows computer with a telescope more than
one time, I recommend that you [set up ASCOM on your
computer.](ascom_setup.md)

### INDI/INDIGO

INDI and INDIGO are two identical-ish alternatives to ASCOM.  The goal
is to make something that works on any computer. It/they are much
newer and much more ambitious than ASCOM, so there seem to be more
rough edges and hiccups.


There are reports that it works with MacOS/Stellarium/OnStep.
However I have never tried this.
