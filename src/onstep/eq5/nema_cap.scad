$fn=100;

// Connector housing that attaches to rear face of a NEMA motor.
// Replace 2 of 4 NEMA body screws with replacements that are longer. 


// use comments to select motor size

// NEMA 17
  nema_face_xy = 42/2;           // x,y position of face edge
  nema_screw_xy = 31/2;          // x,y of screw 
  nema_backplate_l = 9.0;       // thickness of rear plate of motor
  nema_screw_d = 2.8;           // M3 screw 
  nema_screw_loose_d = 3.4;     // M3 screw 
  nema_screw_inset_h = 2.5;     // depth of countersink
  nema_screw_inset_d = 6.6;     // diam of countersink
  nema_screw_l = 40;            // stock screw length
  nema_long_screw_l = 60;       // replacement screw length
  nema_extension_l =            // extra screw length available
    nema_long_screw_l - 
    nema_screw_l;



// NEMA 8
/*
  nema_face_xy = 20/2;
  nema_screw_loose_d = 2.2;    // M2 screw 
  nema_face_roc = 2;            // radius of curvature
*/


nema_face_roc =  nema_face_xy
               - nema_screw_xy;   // body corner radius of curvature 

wall_t = 2.0;                   // thickness of wall
lid_t = 2.0;                    // thickness of lid
  

// Connector is modeled as a simple box.
// It is placed upside down on rear face of motor.
// A pcb is placed above the connector, with a small
// clearance before the lid.

// connector shape/placement info

conn_shape = [
  15.75,        // x:width of connector face
  18.2,         // y:length front to back
  13.2          // z:height of connector face
];

conn_slop_x = 0.3;      // gap allowance on each side
conn_slop_z = 0.3;      // gap allowance on top

conn_inset = 1.0;       // setback from edge of motor
conn_base_z = 0;        // connector sits on motor

// location of center of connector
conn_loc = [
  -3.7,
  nema_face_xy - conn_shape.y/2 - conn_inset,
  conn_base_z + conn_shape.z/2
];

// pcb shape/placement info

pcb_shape = [
  28,            // width of side with connector
  25,            // length, front to back
  1.5           // thickness
];

pcb_inset = 1.4;    // pcb inset from connector front
pcb_standoff = 2;   // gap betw pcb and lid

// location of pcb center

pcb_loc = conn_loc + [
  0,
  +conn_shape.y/2 - pcb_inset - pcb_shape.y/2,
  +conn_shape.z/2 + pcb_shape.z/2
];

// pcb holes are symmetric about  centerline

pcb_hole_x = 11;    // half distance betw holes
pcb_hole_y = 10;    // half distance betw holes
pcb_hole_d = 4;

// 2d location relative to pcb center
pcb_hole_loc_2d = [
  [ + pcb_hole_x,    + pcb_hole_y,  0 ],
  [ + pcb_hole_x,    - pcb_hole_y,  0 ],
  [ - pcb_hole_x,    - pcb_hole_y,  0 ],
  [ - pcb_hole_x,    + pcb_hole_y,  0 ],
];


module pcb_holes_2d(d=pcb_hole_d) {
  translate([pcb_loc.x, pcb_loc.y]) {
    for (v=pcb_hole_loc_2d) {
      translate(v) {
        circle(d=d);
      }
    }
  }
}


module pcb() {

  difference() {
    translate(pcb_loc - 0.5*pcb_shape) {
      cube(pcb_shape);
    }
    translate(pcb_loc) {
      for (v=pcb_hole_loc_2d) {
        translate(v) {
          cylinder(d=pcb_hole_d, h=1000, center=true);
        }
      }
    }
  }
}


module connector(dx = 0, dy=0, dz=0) {
  shape = conn_shape + [dx, dy, dz];
  loc = conn_loc - 0.5*shape;
   // [-shape.x/2, -shape.y/2, -shape.z/2];
  translate(loc) {
    cube(shape);
  }
}


lid_z = pcb_loc.z + 0.5* pcb_shape.z + pcb_standoff;

// Bosses have a slotted nubbin pointing down
// through pcb holeand a post pointing up to lid.

module pcb_bosses() {

    
  d1 = pcb_hole_d - .5;    // nubbin diam
  h1 = pcb_shape.z *2;      // nubbin height

  d2 = pcb_hole_d + 1.0;    // post diam
  h2 = pcb_standoff;        // post height

  slot_w = 0.25;

  // start at top surface of pcb
  translate(pcb_loc + [0,0,pcb_shape.z/2]) {
    for (v=pcb_hole_loc_2d) {
      translate(v) {
        // nubbins
        translate([0,0, - h1]) {
          difference() {
            cylinder(d=d1, h=h1);
            // slots
            translate([-500, -slot_w/2, -500]) {
              cube([1000, slot_w, 1000]);
            }
          }
        }
        // posts
        cylinder(d=d2, h=h2);
      }
    }
  }
}

module wall_2d() {
  difference() {
    nema_face_2d();
    nema_face_2d(r=nema_face_roc -wall_t);
  }
  difference() {
    nema_screws_2d(odd=false, d=2*nema_face_roc- 0.6*wall_t);
    nema_screws_2d(odd=false, d=nema_screw_loose_d);
  }
}

wall_h = lid_z;
module wall() {
  difference() {
    linear_extrude(height = wall_h, convexity=10) {
      wall_2d();
    }
    // inner cutout houses connector profile
    translate([0,0, 0]) {
      connector( dx = conn_slop_x,
                 dz = conn_slop_z);
    }
    // outer cutout provides retaining "window"
    translate([0, 2*conn_inset, 0]) {
      connector( dx = -2.0,
                 dz = 0);
    }
  }
}

module lid_2d() {

  locs = nema_screw_locs_2d();
  difference() {
    nema_face_2d();
    nema_screws_2d(odd=false);
  }
}

module lid(h = lid_t) {

  translate([0,0,lid_z]) {
    linear_extrude(height = h) {
      lid_2d();
    }
  }
}    

// Feet that protrude down into NEMA screw countersinks
// on back of motor.


module feet() {

  d = nema_screw_inset_d - 0.6;
  h = nema_screw_inset_h - 0.2;

  for (v=nema_screw_locs_2d(odd=false)) {
    translate(v) {
      difference() {
        translate([0,0,-h]) {
          cylinder(d=d, h=h);
        }
        cylinder(d=nema_screw_loose_d, h=1000, center=true);
      }
    }
  }
}


// 2d outline of motor body screw holes

function nema_screw_locs_2d(odd=true, even=true) = [
  if (even)
    [ +nema_screw_xy, +nema_screw_xy],      // top right
  if (odd)
    [ +nema_screw_xy, -nema_screw_xy],      // top left
  if (even)
    [ -nema_screw_xy, -nema_screw_xy],      // bottom left
  if (odd)
    [ -nema_screw_xy, +nema_screw_xy],      // botom right
];


module nema_screws_2d(d=nema_screw_loose_d, odd=true, even=true) {
   
  for (v=nema_screw_locs_2d(odd=odd, even=even)) {
    translate(v) {
      circle(d=d);
    }
  }
}

// 2d outline of motor face
module nema_face_2d(r=nema_face_roc) {
  hull() {
    nema_screws_2d(d=2*r);
  }
}


module motor_body() {
  h1 = nema_backplate_l - nema_screw_inset_h;
  h2 = nema_screw_inset_h;

  translate([0,0,-nema_backplate_l]) {
    linear_extrude(height = h1) {
      difference() {
        nema_face_2d();
        nema_screws_2d(d=nema_screw_loose_d);
      }
    }
  }

  translate([0,0,-h2]) {
    linear_extrude(height = h2) {
      difference() {
        nema_face_2d();
        nema_screws_2d(d=nema_screw_inset_d);
      }
    }
  }
}

module screw_extensions(d=nema_screw_d, caps=true) {

  locs = nema_screw_locs_2d(odd=false);
  h = nema_extension_l +nema_backplate_l - nema_screw_inset_h;

  for (v=locs) {

    translate(v) {
      translate([0,0,-nema_backplate_l]) {
        cylinder(d=d, h = h);
      }
      if (caps) {
        translate([0,0, nema_extension_l - nema_screw_inset_h]) {
          cylinder(h=nema_screw_inset_h, d=nema_screw_inset_d);
        }
      }
    }
  }
}



// color("grey") motor_body();
//color("silver") screw_extensions();

//cover();
module cover() {
  wall();
  color("silver") connector();
  color("green") pcb();
  pcb_bosses();
  color("pink") lid();
  feet();
}


print_cover();
module print_cover() {
  rotate([180,0,0]) {
    lid();
    wall();
    pcb_bosses();
    feet();
  }
}

