# Celestron EQ5 Onstep Conversion

## Background 

Our Celestron mount was purchased with the model name AS-GT. This
rather short-lived model was identical to the widely known EQ5 mount,
with the addition of a GoTo system.  Unfortunately, the AS-GT
electronics self-destructed during a firmware upgrade, so our mount
essentially became an EQ5.

## Drive Drain Description

For both axes, the drive train consists of a 400-step NEMA 17 stepper
motor, a right-angle NEMA 17 mounting bracket, and a belt drive
reduction consisting of GT2 standard 6mm wide timimng belt and pulleys.

Using 16 and 60 teeth pulleys, the 144:1 gear reduction of the worm
drives, and 16 microsteps per step gives us:

[400 \* 16 \* (60/16) \* 144]/360 = 9600 microsteps per degree of axis rotation.


## Adapters

Attaching drives to the EQ5 mount, which was not originally designed
to be motorized, is a bit tricky.  In this design, we use stock
right-angled motor mounts and a custom 3D printed adapter. For each
axis the adapter is different and the length of the timing belt is
different.  The adapters take advantage of existing holes in the EQ5
mount; no orinal hardware was modified.

The drive system was designed in OpenSCAD.  The [OpenSCAD source
code](Celestron_ASGT.scad) is used to generate the STL files for the
[RA adapter](eq5_ra_plate.stl) and the [Dec adapter](eq5_dec_plate.stl).

For the electrical connection to the motors, a housing was designed to
hold an RJ45 breakout board to the rear end of the motor. As before,
the [OpenSCAD source file](nema_cap.scad) was used to generate the
[STL file](nema_cap.stl) for 3D printing.




## Purchased Parts

All of the following purchased on Amazon.

* [NEMA 17 stepper motor](stepper.pdf)
* [NEMA 17 right angle bracket](bracket.pdf)
* GT2 pulley, 6mm wide, 16 teeth, 5mm bore
* GT2 pulley, 6mm wide, 60 teeth, 6mm bore
* GT2 timing belt, 6mm width, 180mm length, 90 teeth. (Declination) 
* GT2 timing belt, 6mm width, 158mm length, 79 teeth. (RA)

##  Additional upgrades to the EQ5 mount

* 3D printed [upper cover](eq5_polar_cover_upper.stl) for the polar scope.

* 3D printed [lower cover](eq5_polar_cover_lower.stl) for the polar scope.




