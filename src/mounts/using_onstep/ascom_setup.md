# Installing ASCOM for OnStep

## 1) Install ASCOM Platform

* Download the latest **ASCOM Platform** from the [ASCOM Downloads
  page](http://ascom-standards.com/Downloads/index.htm). You don't
  need any other downloads from the ASCOM website.

* If you have an older version of ASCOM Platform, it is best to
  uninstall it now.

* Install ASCOM Platform.  As part of this process, the installer will
  also download and install a compatible version of the Microsoft .NET
  software.

Now, any time you run an ASCOM-compliant program on your computer, it
will talk to this ASCOM Platform software to satisfy all of its
astronomical needs.

## 2) Install the OnStep ASCOM Driver

* Download the latest version of the [OnStep ASCOM unified 
  driver](http://stellarjourney.com/main/onstep-ascom-driver-software/).

* Install the driver.

Now, when someone asks the ASCOM software to do something OnStep-y, it
knows how to actually do it.

## A Quick Test

For now, we're just going to peek at the "OnStep Telescope Setup"
window to make sure the installation went okay.

* On your Desktop, there should be an icon for **ASCOM Diagnostics**.
  If not, use the Start Menu or search box to find it.

Note: There may be another Desktop icon called **ASCOM Profile
Explorer**.  Go ahead and delete that.

* Start the ASCOM Diagnostics program.

* Click **Choose Device --> Choose and Connect to Device**

* At the top left, use the **Select Device Type** selection box to
  choose **Telescope**.

* Click on **Choose**.  This will create a popup window called
  "Telescope Chooser."

* In the popup, click the selection box.  There should already be a
  few choices available, as ASCOM comes with simulators for most kinds
  of devices.

* Look at the available selections and make sure that **OnStep
  Telescope** is one of them.

* Not there?  Something has gone wrong.

* After selecting **Onstep Telescope**, click on **Properties**.  This
  will pop open a new window called **OnStep Telescope Setup**.

That's all we really need for now.  If you made it here, your ASCOM
software is properly installed and you are ready to observe.

