//Edits:
// reduce dp_z1, dp_z2 by 1 mm to loosen belt.


$fn = 100;

// Celestron AS-GT mount

// IDEA: create simple plates, attach NEMA brackets to them. 

// NEMA 17 bracket info

nb_t = 2.85;        // thickness of plate
nb_w = 49.5;        // perpendicular to motor axis
nb_l = 50.6;        // back of bracket to mount surface
nb_h = 51.4;        // top of bracket to bottom surface
nb_axis_h = 30.0;   // height of axis above bottom surface
nb_slot_w = 4.4;    // width of slots
nb_slot_sep = 30;   // dist betw slots
nb_slot_l = 34.2;   // length of slots
nb_slot_stop = 8.3; // meat betw slot and rear
                    // i.e., slots essentially centered
//nb_screw_d = 4.2;   // M4 screw, clearance
nb_screw_d = 3.8;   // M4 screw, tap
nb_nut_d = 7.0;     // FIXME:  slot width to capture nut


// RA plate

// Coordinate system:
//    origin on lower plate surface, centered on screw axis
//    +x to right
//    +y up along plate surface
//    +z up along screw axis

// RA late consists of two rectangular layers.
// Lower layer fits between casting ridges.
// Upper layer extends to the right for motor support. 
// Below the plate is a wedge that allows for (slight) +/- y
// adjustment for belt tension fine tuning. 

rap_x0 =  -26.0;            // x, left edge of both layers
rap_x1 =  +26.0;            // x, right edge of lower layer
rap_x2 =  +34.6;            // x, right edge of upper layer
rap_y1 = 13.0;              // y, upper edge
rap_y0 = rap_y1 - nb_w + 2; // y, lower edge (tiny bracket overhang) 
rap_z0 =    0.0;            // z, bottom of lower layer
rap_z1 =    3.1;            // z, lower/upper layer boundary
rap_z2 =    9.5;            // z, top of upper layer

// check: rap_z2 + nb_t >= mounting screw length (=12)

// location for NEMA bracket

rap_nema_adj = 0.5;     // ADJUST: tune RA center distance
rap_nema_y = rap_y1 - nb_w/2 - rap_nema_adj;
rap_nema_x = rap_x2;
rap_nema_z = rap_z1;

// location of RA worm axis

raw_y = 26.0;
raw_z = 36.0;

// location of RA motor axis

ram_y = rap_nema_y;
ram_z = nb_axis_h + (rap_z2 - rap_z0);

// calculate center distance
// Note: about 0.6 - 0.9 mm of slop from NEMA bracket slots

ra_cd = sqrt( pow(ram_y - raw_y, 2) + pow(ram_z - raw_z, 2) );
echo("RA center distance", ra_cd);


// check belt length

// gt2_60_16_160 = 39.5;
// gt2_60_16_158 = 38.4;


ra_screw_tap_d =    4.8;    // M5 screw, self tap
ra_screw_loose_d  = 5.2;    // M5 screw, easy passage
ra_nut_ffd = 7.9;           // flat-to-flat distance, M5 nut
ra_nut_h =  3.85;


module ra_nema_holes_2d() {
  x = rap_x2 - nb_l/2;
  dx = (nb_slot_l - nb_slot_w)/2; 
  y = rap_nema_y;
  dy = nb_slot_sep/2;  

  // 1 upper hole, 2 lower
  // manually optimize placement
  locs = [
    [ x + dx - 5, y + dy],
    [ x - dx,      y - dy],
    [ x + dx - 5,      y - dy]
  ];
    
  for (v=locs) {
    translate(v) {
      circle(d= nb_screw_d);
    }
  }
}

module ra_screw_2d(d=ra_screw_loose_d) {
  circle(d=d);
}

module ra_nut_2d(xtra=0.2) {
  // xtra=0.2 works great
  d = 1.155 * (ra_nut_ffd+xtra);  // diameter (circle of points)
  circle($fn=6, d=d);
}

// RA casting info

rac_ROC = 40.0;         // radius of RA cavity bottom
rac_screw_dy = 16.25;   // distance between screw and diameter
// calculate tilt angle of casting at screw axis
rac_theta = asin(rac_screw_dy/rac_ROC);

// RA wedge below plate, provides tension adjustability
// Center on screw axis.

raw_dx = 38.0;          // x size of wedge 
raw_dy = 26.0;          // y size of wedge
raw_dz = 9.75;          // z height of wedge on screw axis
raw_slot = 3;           // slot in y for screw hole
raw_adj_d = 2.5;        // horizontal pilot hole for adjusters
raw_adj_x = 10;
raw_adj_z = -5;         // z pos of adjusters 

module ra_wedge() {
  x = raw_dx/2;
  y = raw_dy/2;
  delta_z = y*sin(rac_theta);
  mirror([0,0,1]) {
    difference() {
      hull() {
        translate([-x, -y, 0]) {
          cube([raw_dx, 0.01, raw_dz - delta_z]);
        }
        translate([-x, +y, 0]) {
          cube([raw_dx, 0.01, raw_dz + delta_z]);
        }
      }
      hull() {
        hole_d = ra_screw_loose_d;
        translate([0, +raw_slot/2, 0]) {
          cylinder(d=hole_d, h=999, center=true);
        }
        translate([0, -raw_slot/2, 0]) {
          cylinder(d=hole_d, h=999, center=true);
        }
      }

      //adjuster holes
      for (x= [-raw_adj_x, +raw_adj_x]) {
        translate([x, 0, -raw_adj_z]) {
          rotate([-90,0,0]) {
            cylinder(d=raw_adj_d, h=999);
          }
        }
      }
    }
  }
}



module ra_plate_2d(x_right = rap_x1) {
  dx = x_right - rap_x0;
  dy = rap_y1 - rap_y0;

  difference() {
    translate([rap_x0, rap_y0]) {
      square([dx,dy]);
    }
    ra_nema_holes_2d();
  }
}


module ra_plate() {
  // lower level
  linear_extrude(height = rap_z1) {
    difference() {
      ra_plate_2d();
      ra_nema_holes_2d();
      ra_nut_2d();
    }
  }
  // upper level
  translate([0,0, rap_z1-0.001]) {
    linear_extrude(height = rap_z2-rap_z1) {
      difference() {
        ra_plate_2d(x_right = rap_x2);
        ra_nema_holes_2d();
        ra_nut_2d();
      }
    }
  }
  // wedge
  ra_wedge();

}


// DEC plate

// coordinate system:
// +x to right, 0 at center
// +y up along plate, 0 at center of mount holes
// +z up perp to plate, 0 at lower surface of plate.


dp_ROC = 6.0;           // corner radius of curvature
dp_xr =  +31.0;         // RH end of plate
dp_xl =  -31.0;         // LH end of plate
dp_yt =  +11;           // WARNING: 13mm max!!!
dp_yb =  dp_yt - nb_w;  // same width as NEMA bracket


// Adjust plate thickness (z2) for belt length.

dp_z0 =         0.0;        // bottom of plate

// belt was too tight
//dp_z1 =         3.0;        // height of mount screw through hole
//dp_z2 =         7.35;        // ADJUST:thickness of plate

dp_z1 =         2.0;        // height of mount screw through hole
dp_z2 =         6.35;        // ADJUST:thickness of plate

// 4.3 is a good minimum value 
echo("countersink", dp_z2 - dp_z1);


dp_dx = dp_xr - dp_xl;
dp_dy = dp_yt - dp_yb;

// two deck plate screws (M4) attach plate to mount

// 4.7 is too loose
dps_d  = 4.2;           // M4 clearance
dps_head_d = 8.0;       // clearance for head
dps_head_h = 3.9;       // height of cap screw head
dps_x = 25.8;           // disdt from center line

// calculate center distance for dec drive

dw_z = -12.5;               // dec worm_axle z
dw_y = -18.0;               // dec worm axle y

dm_z = dp_z2 + nb_axis_h;   // dec motor axle z
dm_y = dp_yt - nb_w/2;      // dec motor axle y

d_cd = sqrt( pow(dm_z - dw_z, 2) + pow(dm_y - dw_y, 2));
echo("Dec Center Distance", d_cd);

// Center distance for some pul1ey_pulley2_belt choices

gt2_60_16_158 = 38.42;
gt2_60_16_180 = 50.03;
gt2_60_16_200 = 60.37;


// a ridge to align dec plate to mount

module dp_ridge() {
  // make ridge as a hull of two rectangles, lower and upper
  dx_b = 40;
  dy_b = 4;
  dx_t = 34;
  dy_t = 2;
  dz =   4;

  rotate([ 0,180,0]) {
    translate([0,-dp_ROC, -0.01]) {
      hull() {
        translate([-dx_b/2, 0, 0]) {
          cube([dx_b, dy_b, 0.01]);
        }
        translate([-dx_t/2, 0, dz]) {
          cube([dx_t, dy_t, 0.01]);
        }
      }
    }
  }
}


// holes for mounting plate to mount
module mount_holes_2d(d=dps_d) {
  for (x = [-dps_x, +dps_x]) {
    translate([x, 0]) {
      circle(d=d);
    }
  }

}



// Place 3 holes to mount NEMA bracket to dec plate..
// NEMA mount face referenced to dec plate left edge.

module dp_nema_holes_2d(d=nb_screw_d) {

  xadj = 0.0;                   // fine tune x alignment
  
  xmid = dp_xl + nb_l/2;        // reference x to left edge
  ymid = (dp_yt + dp_yb)/2;     // y centered on plate 
  dx = nb_slot_l/2 -2;          // end of slot - screw diam/2
  dy = nb_slot_sep/2;           // half slot separation

  // locations of holes
  locs = [
    [ xmid - dx, ymid - dy],
    [ xmid + dx, ymid - dy],
    [ xmid,      ymid + dy],
  ];

  for (v=locs) {
    translate(v) {
      circle(d=d);
    }
  }
  
}

// plate profile is rectangle with rounded corners
module dp_main_2d() {
  xl = dp_xl + dp_ROC;
  xr = dp_xr - dp_ROC;
  yb = dp_yb + dp_ROC;
  yt = dp_yt - dp_ROC;
  locs = [
    [xl, yb],
    [xl, yt],
    [xr, yt],
    [xr, yb],
  ];
  hull() {
    for (v=locs) {
      translate(v) {
        circle(r=dp_ROC);
      }
    }
  }
}

// dec plate body
module dp_main() {
  // lower level: mount screw clearance, bracket hole tap
  linear_extrude(height = dp_z1-dp_z0, convexity=10) {
    difference() {
      dp_main_2d();
      mount_holes_2d(d = dps_d);
      dp_nema_holes_2d(d = nb_screw_d);
    }
  }
  // upper level: mount screw countersink, bracket hole tap
  translate([0,0,dp_z1 - 0.01]) {
    linear_extrude(height = dp_z2-dp_z1, convexity=10) {
      difference() {
        dp_main_2d();
        mount_holes_2d(d = dps_head_d);
        dp_nema_holes_2d(d = nb_screw_d);
      }
    }
  }
}

// the worm gear housing can sit a tiny bit proud of the z=0 plane, for y>6
module dp_worm() {
  worm_h = 1.0;
  worm_y = 6.0;
  translate([-500, worm_y, worm_h]) {
    mirror([0,0,1]) {
      cube(1000);
    }
 }
}

module dec_plate() {
  difference() {
    dp_main();
    dp_worm();
  }
  dp_ridge();
}



// NEMA bracket coords:
// origin on motor axis at inner (mounting) face
// +x along motor axis away from motor
// +y along mounting surf, parallel to base
// +z perp to base

module nema_base_2d() {
  difference() {
    translate([-nb_l, -nb_w/2]) {
      square([nb_l, nb_w]);
    }
    nema_slots_2d();
  }
}

module nema_base() {
  translate([0,0, -nb_axis_h]) {
    linear_extrude(height=nb_t, convexity=10) {
      nema_base_2d();
    }
  }
}
module nema_face() {
  translate([0, -nb_w/2, -nb_axis_h]) {
    cube([nb_t, nb_w, nb_h]);
  }
}


module nema_slots_2d() {

  y = nb_slot_sep/2;
  xmid = -nb_l/2;
  dx = nb_slot_l/2;

  for (y=[-y, +y]) {
    hull() {
      for (x=[xmid - dx, xmid+dx]) {
        translate([x, y]) {
          circle(d=nb_slot_w);
        }
      }
    }
  }
}

module nema_bracket(reverse=false) {
  if (reverse) {
    rotate([0,0,180]) {
      nema_base();
      nema_face();
    }
  } else {
    nema_base();
    nema_face();
  }      
}

if (0) {
  nema_bracket(reverse=true);
  translate([ -dp_xl,
              - dp_yt + nb_w/2,
              -nb_axis_h - dp_dz]) {
    dec_plate();
  }
}
if (1) {
  rotate([180,0,0])
    dec_plate();
}
if (0) {
  rotate([180,0,0])
    ra_plate();
}