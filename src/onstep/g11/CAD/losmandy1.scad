include <MCAD/motors.scad>

$fn = 100;


// standard properties nema 17 motor

nema_hole_sep = 31;		// dist between mounting holes
nema_pilot_d = 22;		// centration pilot diameter
nema_pilot_l = 2;		// centration pilot length
nema_screw_diam = 3;		// M3 mounting screws
nema_width = 42.3;		// width of motor face
nema_ROC = 5.5;			// ROC for corners of face
nema_shaft_d = 5;

// properties of our particular nema 17 motor

nema_len = 48;			// length of motor body
nema_shaft_len = 24;	// length of shaft protrusion from face
nema_dcut_len = 15;		// length of flatted part of shaft

// properties of Losmandy G11 mount

g11_shaft_gap = 6;		// dist betw shaft ends (motor and worm)
g11_worm_inset = 19.5;		// dist from plate edge to worm shaft end
g11_plate_thick = 8.4;		// thickness of g11 worm plate
g11_hole_sep = 47.65;		// dist betw mounting holes
g11_hole_offset = 12.7;		// dist from hole axis to motor axis
g11_screw_d = 0.1440 * 25.4;	// 6-32 clearance hole

// how far the motor shaft protrudes past the plate edge (in -z direction)
nema_protrusion = g11_worm_inset - g11_shaft_gap;
// how far the motor need to be spaced to achieve this (in +z direction)
nema_face_offset = nema_shaft_len - nema_protrusion;

plate_thick = nema_face_offset;


// properties of RJ45 adapter PCB (pin header in +y direction)

pcb_dx = 34;		// PCB size x
pcb_dy = 27.81;		// PCB size y
pcb_t = 1.57;		// PCB thickness
pcb_hole_dx =  28;	// hole sep in x
pcb_hole_dy = 11;	// hole sep in y
pcb_hole_y_off = 11.5;	// dist pin header edge to holes
pcb_screw_diam = 3;	// M3 hole (possibly 6-32?)
pcb_screw_clearance = 4;

// PCB location info

pcb_standoff = 10;	// height above mount plate
pcb_standoff_diam = 8;  // diameter of standoffs
pcb_nema_gap = 5;	// space betw pcb edge and motor

// lower part of plate will be a "deck" for 
//  adding connector adapter, lid, etc.

deck_thick = plate_thick;  //for now...?

// objects on top of the deck will use the following origin

deck_origin = [ 0, -nema_width/2 - pcb_nema_gap, deck_thick];

deck_dy = 40;
deck_dx = nema_width;

// RJ connector on PCB
rj_dx = 16;         // x size of metal box
//rj_dy = 16.6;       // y size of metal box
rj_dy = 17.0;       // y size of metal box
rj_dz = 16.5;       // z size of metal box
//rj_y_off = 10.75;   // edge of PCB to box
rj_y_off = 9.75;   // edge of PCB to box

             
rj_xy_loc = [0, - rj_y_off -rj_dy/2];

// cover for PCB is 3 sided box plus top

cov_wall_thick = 4; // thickness of walls
cov_dx = 42;        // x sep of wall midlines
cov_dy = 33;        // y sep of wall midlines
cov_ROC = 5;        // radius of curvature of wall centerline

cover_height = pcb_standoff + pcb_t + 0.5*rj_dz;

// Use a hull of circles to make a round-cornered rectangle. 
// Use delta for (small) changes in ROC.

module cover_shape_2d(delta=0) {
  // center of circles are inbound of defining corners
  xx = cov_dx/2 -cov_ROC;
  yy = cov_dy/2 -cov_ROC;
  center = [
             [ -xx-5, +yy],
             [ -xx, -yy],
             [ +xx, -yy],
             [ +xx+5, +yy]
  ];

  // modify ROC to keep center of circles constant
  ROC = cov_ROC + delta;
  translate([0, -cov_dy/2+ cov_wall_thick/2 + 0.5]) {
    hull() {
      for (c=center) {
        translate(c) {
          circle(r=ROC);
        }
      }
    }
  }
}

module wall_2d(thick=cov_wall_thick) {
  difference() {
    cover_shape_2d(delta=+thick/2);
    cover_shape_2d(delta=-thick/2);
  }
}

module wall() {
  difference() {
    linear_extrude(height=cover_height, convexity=10) {
      wall_2d();
      lid_holes_2d(diam=8);
    }
    translate([0,0,-.01]) {
      ridge(delta_w=0.1, delta_h=0.1);
      linear_extrude(height = cover_height+0.2) {
        lid_holes_2d();
      }
    }
  }
}

ridge_h = 1;
ridge_w = 1;

module ridge(delta_w=0, delta_h=0) {
  linear_extrude(height=ridge_h+delta_h)
    wall_2d(thick=ridge_w +delta_w);
}

module lid_holes_2d(diam=pcb_screw_diam){
  lh_x = 21.5;
  lh_y = -7;
  translate([ +lh_x, lh_y])
    circle(d=diam);
  translate([ -lh_x, lh_y])
    circle(d=diam);
}

module lid() {
  translate([0,0,cover_height - cov_wall_thick + 0.1]) {
    linear_extrude(height=cov_wall_thick) {
      difference() {
        cover_shape_2d();
        rj_conn_2d(dx=1, dy=1);
      }
    }
  }
}

module rj_conn() {
  translate([0,0,pcb_standoff+pcb_t]) {
    linear_extrude(height=rj_dz) {
      rj_conn_2d();
    }
  }
}

module rj_conn_2d(dx=0, dy=0){
  w=rj_dx + dx;
  h=rj_dy + dy;
    
  translate(rj_xy_loc) {
    square([w,h], center=true);       
  }
}

// calculate location of pcb center
pcb_loc = [0,
	   - pcb_dy/2,
	   pcb_standoff];

// calculate location of pcb holes center
pcb_hole_loc = [0,
		- pcb_hole_y_off - pcb_hole_dy/2,
		pcb_standoff];


// passage for wires along motor, into case
chim_dx = 5;
chim_dy= 3;
hole_dz = 6;
chim_ROC = 1;
module chimney() {
  translate([0, +cov_wall_thick, -0.1]) {
    linear_extrude(height=cover_height + 0.2) {
      hull() {
        xx = chim_dx/2 - chim_ROC;
        yy = chim_dy/2 - chim_ROC;
        translate([-xx, -yy]) circle(r=chim_ROC);
        translate([-xx, +yy]) circle(r=chim_ROC);
        translate([+xx, +yy]) circle(r=chim_ROC);
        translate([+xx, -yy]) circle(r=chim_ROC);
      }
    }
    cube([chim_dx, 2*cov_wall_thick, 2*hole_dz],
         center=true);
  }
}

///  MAIN OBJECT PLACEMENT


// CHOOSE OBJECTS TO DISPLAY (1=true, 0=false)

show_plate = 1;
show_cover = 1;
flip_cover = 0;   // use only if othjer objects hidden
show_extras = 1;

if (show_plate) {
  color("blue") plate();
}

if (show_cover) {
  if (flip_cover) {
    // place cover upside down for printing
    translate([0,0, cover_height]) {
      rotate([180,0,0]) {
        color("red") cover();
      }
    }
} else {
    translate(deck_origin) {
      color("red") cover();
    }
  }    
}

if (show_extras) {
  color("gray") motor();
  translate(deck_origin) {
    color("green") pcb();
    color("silver") rj_conn();
  }
}

module plate() {
  difference() {
    plate_blank();
    nema_screws();
    nema_pilot();
    mount_screws();
    translate([0, deck_origin.y, -0.01]) {
      linear_extrude(height = plate_thick + 0.02) {
        pcb_holes_2d(diam=pcb_screw_diam);
        lid_holes_2d(diam=pcb_screw_clearance);
      }
    }
  }
  translate(deck_origin + [0, 0, -.01]) {
    ridge(delta_w=-0.1);
    standoffs();
  }
}

module cover() {
    difference() {
      union() {
        wall();
        lid();
      }
      chimney();
    }
}


/*
rotate([180,0,0]) {
  wall();
  lid();
}
*/


module pcb_holes_2d(diam=pcb_screw_diam) {
  dx = pcb_hole_dx/2;
  dy = pcb_hole_dy/2;
  locs = [
	  [ +dx, +dy],
	  [ +dx, -dy],
	  [ -dx, -dy],
	  [ -dx, +dy]
	 ];
	  
  translate(pcb_hole_loc) {
    for (v=locs) {
      translate(v) {
	circle(d=diam);
      }
    }
  }
}

module standoffs(diam=pcb_standoff_diam) {
  difference() {
    translate([0,0,-0.1]) {
      linear_extrude(height = pcb_standoff + 0.1)
        pcb_holes_2d(diam=diam);
    }
    translate([0,0,-0.2]) {
      linear_extrude(height = pcb_standoff + 0.3)
        pcb_holes_2d(diam=pcb_screw_clearance);
    }
  }
}

module pcb() {
  difference() {
    translate(pcb_loc) {
      linear_extrude(height=pcb_t) {
	    square([pcb_dx, pcb_dy], center=true);
      }
    }
    translate([0,0,pcb_standoff-0.1]) {
      linear_extrude(height=pcb_t+.2)
        pcb_holes_2d(diam=pcb_screw_clearance);
    }
  }
}


module mount_screws() {
  cs_d = 0.25 * 25.4;		// diam  for 6-32 socket head cap screw head
  cs_h = 0.15 * 25.4;		// depth for 6-32 socket head cap screw head
  
  dd = cs_d - g11_screw_d;	// calc difference in diam

  translate([0,0,-0.1]) {
    linear_extrude(height=plate_thick+0.2) {
      mount_screws_2d();
    }
  }
  translate([0,0,plate_thick - cs_h]) {
    linear_extrude(height = cs_h + 0.1) {
      mount_screws_2d(diam=cs_d);
    }
  }
}


module mount_screws_2d(diam=g11_screw_d) {
  dx = g11_hole_sep/2;
  dy = g11_hole_offset;

  locs = [  [ +dx, -dy],
	    [ -dx, -dy]  ];
  for (v=locs) {
    translate(v) {
      circle(d=diam);
    }
  }
}


module nema_pilot() {
  h = plate_thick+0.2;
  translate([0,0,-0.1])
  linear_extrude(height = h) {
    nema_pilot_2d();
  }
}

module nema_screws() {
  cs_d = 6;		// diam of countersink
  cs_h = 4;		// depth of countersink 

  translate([0,0,-0.1]) {
    linear_extrude(height=cs_h+0.1) {
      nema_holes_2d(diam=cs_d);
    }
  }
  translate([0,0,-0.1]) {
    h= plate_thick + 0.2;
    linear_extrude(height=h) {
      nema_holes_2d();
    }
  }
}




module plate_blank() {
  linear_extrude(height = plate_thick) {
      hull() {
        nema_face_2d();
        mount_screws_2d(diam=12);
        translate([0,-5])
          mount_screws_2d(diam=12);
      translate( [ 0, deck_origin.y]) {
        cover_shape_2d(delta=cov_wall_thick/2);
      }                    
    }
  }
}






// set of 2D screw holes
module nema_holes_2d(diam=nema_screw_diam) {
  l = nema_hole_sep/2;
  locs = [
    [ +l, +l],
    [ +l, -l],
    [ -l, -l],
    [ -l, +l]
  ];

  for (v=locs) {
    translate(v) {
      circle(d=diam);
    }
  }
}

// 2D pilot hole
module nema_pilot_2d(diam=nema_pilot_d) {
  circle(d=diam);
}

// 2D shape of motor face
module nema_face_2d(diam=2*nema_ROC) {
  hull() {
    nema_holes_2d(diam);
  }
}

module motor() {
    translate([0,0,plate_thick]) {
      linear_extrude(height=nema_len) {
        nema_face_2d();
      }
    }
}
