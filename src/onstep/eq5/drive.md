# Drive System for the EQ5 Mount

## Description

The DC gearmotors that came with the mount were removed. For each
axis, this left a worm drive with a ratio of 144:1.  This ratio is
still a bit high for fine control, so a further reduction was
introduced using toothed fan belts and pulleys. Using commonly
available pulleys with 16 and 60 teeth, 400-step stepper motors, and
16 microsteps, the final drive ratio is:

[(60/16) \* 400 \* 16 \* 144]/360 = 9600 microsteps per degree of axis rotation


## Details




