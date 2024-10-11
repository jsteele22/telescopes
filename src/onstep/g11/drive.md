# Losmandy G11 Drive System.

## Background

On the stock G11, each axis had a DC gearmotor coupled to a worm gear
drive. The worm gear ratio is 360:1; i.e., a complete revolution of
the motor outut rotates the axis by 1 degree.

For the OnStep conversion, the original motors and couplers were
removed and the new NEMA 17 stepper motors installed using custom 3D
printed adapters. No physical modifications were made to the mount.

**Note**: The stepper motor take 400 full steps per revolution.  They are
run at 256 microsteps per step.  Thus, the final drive ratio is :

(400 \* 256 \* 360)/360 = 102400 microsteps per degree of axis
revolution.


## Worm Drive Coupler

The new stepper motors have a 5mm D output shaft.  The Losmandy worm
drive has a 1/4' (6.35 mm) input shaft.  For this application a
flexible coupler was purchased from Amazon. ("5mm to 6.35mm Shaft
Coupling 25mm Length 18mm Diameter")

Although the shaft diameters of this coupler are correct, the OD of
the coupler (18mm) is too large to enter the Losmandy worm gear
housing.  Thus, on the 1/4" end of the coupler, the OD had to be
machined down a bit  for clearance.

**Note**: Fasteners on the Losmandy mount are *inch*, not metric.

**Note** Each worm drive is protected by a rectangular cover. These
  can be removed using a 1/16" hex wrench to *loosen* (not remove) two
  tiny set screws. **Do not** loosen or adjust any other part of the
  worm drive system!


## Motor Adapters

The stepper motors are attached to the G11 using 3D printed adapters.
The adapters use the same threaded holes in the G11 mount as the old
motors.

In addition to positioning the stepper motors, the adapters provide an
enclosure for a small RJ45 breakout PCB purchased on Amazon. (Teansic
5 PCS RJ45 Connector Breakout Board 8-pin Headers Network Port
Adapter).  The stepper wire to RJ45 pin mapping matches the RJ45 ports
on the MaxPCB4 OnStep controller.

## Motor Adapter Design.

The adapters were designed in OpenSCAD. The .scad files contain the
source code for the design.  The OpenSCAD program is used to generate
.stl files for 3D printing.


