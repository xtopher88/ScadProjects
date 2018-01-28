// Alorithmic LEGO(r) Technic compatible gear generator
//
// NOTE regarding Patents: Since 1977 the LEGO Group has produced "Technic"
// elements with gear teeth, axles, axle-holes, and other features closely
// resembling the design(s) in this file, as part of their "Expert Builder"
// and "Technical Sets", now called "Technic" (see for example set 961,
// peeron.com/inv/sets/961-1?showpic=9288 ). By 1989 they had added pieces
// with rounded ends (see peeron.com/inv/sets/5264-1?showpic=8542 (set 5264
// from 1987) and peeron.com/inv/sets/5110-2?showpic=8543 (set 5110 from 1989))
// The object(s) produced by this SCAD file are different from real LEGO(r)
// elements, and any similarities of features, such as the shapes of axles
// and axle-holes, are functional in nature. The functions in question
// resemble those in LEGO patents that have already expired (or, if not
// patented, became prior art when the product(s) became available for
// purchase, i.e. 1989 at the latest). Nevertheless, one must not infringe
// on non-expired patents and any non-patent rights, such as LEGO(r)
// trademarks and brand identity. An example of such infringement would be
// to make objects and then try to "pass them off" as LEGO products. See
// for example the Kirkbi AG v. Ritvik Holdings Inc. case, (Supreme Court of
// Canada [2005] 3 S.C.R. 302).
//
// This was originally created by user bjepson on Thingiverse (thing 29989),
// then heavily modified and expanded by Robert Munafo:
//  20121226: separate parameters for rows/columns of cylinder holes and of
//            "plus-shaped" holes
//          * Rotate the holes by 20 degrees to take advantage of
//            edge dithering both for improved hole width resolution
//            and to provide a rough surface which better grips the
//            smooth axles.
//          * You can now get more than just a single row of plus-holes
//            in each direction
//
//  20130105: added MCAD functions to make this file work all by itself (no
//            need to hunt down missing pieces elsewhere)
//          * More accurate axle hole dimensions
//          * Round holes are actually round now (imagine that!)
//          * Automatically determines correct parameters for number and placement
//            of holes, based on number of teeth
//
//  20130106: fix small glitch seen at junction of fillet and bottom land (for
//            illustration of the problem, see "0106-fix.jpg" at
//            thingiverse.com/thing:40410)

// 32 teeth is the real "missing" gear size, because all the other
// multiples of 8 are available. An argument can also be made for 28 (which
// however is available in the new small turntable) or any other multiple of 4
// because the official gears are all multiples of 4, namely: 8, 12, 16,
// 20, 24, 28(turntable), 36, 40 and 56(big turntable).
//
// For my orrery designs ( see mrob.com/orrery ) I might use any integer
// number of teeth from 8 up to around 60 or 70.
//
// The holes parameters need to be chosen a certain way. To get a normal style
// gear with a + hole in the middle, the plus_row and plus_col should both
// be odd, and the holes_row, holes_col should both be even. To get a round
// hole in the center, do it the other way 'round. Then invoke it as
// myGearParamed(n_teeth, holes_row, holes_col, plus_row, plus_col)
//
// Examples:
//          my 20 gear: holes_row=2, holes_col=2, plus_row=1, plus_col=1
//    Standard 24 gear: holes_row=2, holes_col=2, plus_row=1, plus_col=1
//          my 28 gear: holes_row=2, holes_col=2, plus_row=3, plus_col=1
//          my 32 gear: holes_row=2, holes_col=2, plus_row=3, plus_col=3
// nonstandard 36 gear: holes_row=2, holes_col=2, plus_row=3, plus_col=3
//    Standard 40 gear: holes_row=4, holes_col=2, plus_row=3, plus_col=3
//          my 44 gear: holes_row=4, holes_col=2, plus_row=3, plus_col=3
//          my 48 gear: holes_row=4, holes_col=4, plus_row=5, plus_col=3
//
// By default, the myGear function chooses the best values for all the holes paramters
// based on the number of teeth.

/*      
        Customizable Straight LEGO Technic Beam
        Based on Parametric LEGO Technic Beam by "projunk"
        www.thingiverse.com/thing:203935
        Modified by Steve Medwin
        January 2015
*/
$fn=30*1.0;

// Parameters modified for best print on my Replicator 2 with PLA
Pitch = 8*1.0;
Radius1 = 5.1/2;
Radius2 = 6.2/2;//6.5/2;
Height = 7.8*1.0;
Depth = 0.85*1.0;
Width = 7.3*1.0; 

module technic_cutout()
{
    union()
    {
        translate([0,0,-(Height-Depth+0.1)/2]) cylinder(r=Radius2,h=Depth+0.1, center=true);
        cylinder(r=Radius1,h=Height+0.1, center=true);
        translate([0,0,(Height-Depth+0.1)/2]) cylinder(r=Radius2,h=Depth+0.1, center=true);
    }
}

module drawBeamHoles(Holes = 9)
{
    Length = (Holes-1) * Pitch;
    
        for (i = [1:Holes])
        {
             translate([(i-1)*Pitch, 0,0]) technic_cutout();
        }
}

// As an example, make one gear.
height = 8;
difference()
{
difference()
{ 
    myGearParamed(20*4, Width);
    for (i = [1:6])
    {
        rotate([0,0,i*360/6]) translate([2*Pitch, 0,0]) translate([0,0,Width/2]) drawBeamHoles(3);
    }
inner_length = 5.0;
inner_width = 2.2;
    translate([0,0,Width/2])cube([inner_length,inner_width, Width+0.1],center=true);
    translate([0,0,Width/2])cube([inner_width, inner_length, Width+0.1],center=true);
    //translate([0,0,height/2]) cylinder(r=6.5/2, h=height, center=true);
}
    //translate([0,0,height/2]) cylinder(r=3.0/2, h=height+0.1, center=true);
}

module myGearParamed(num_teeth, gearHeight=3.67)
{
  jaggy_angle = 20;
  beam_width = 7.8;  // Needs to be a bit less than the LEGO stud spacing = 7.99 mm

  axle_gap = 1.9;   // axle thickness is actually about 1.8 mm
  hole_radius = 2.65;

    linear_extrude(height = gearHeight, center = false, convexity = 10, twist = 0) {
      gear(number_of_teeth=num_teeth,
        diametral_pitch=1, 
        pressure_angle=88, 
        clearance = 0);
    }
}

// ---------------------------------------------------------------------------------
//
// The following functions (gear, involute_gear_tooth and two minor functions)
// are taken from the "gears.scad" file in the "MCAD" package, which is available
// at https://github.com/D1plo1d/MCAD

// Geometry Sources:
//  http://www.cartertools.com/involute.html
//  gears.py (inkscape extension: /usr/share/inkscape/extensions/gears.py)
// Usage:
//  Diametral pitch: Number of teeth per unit length.
//  Circular pitch: Length of the arc from one tooth to the next
//  Clearance: Radial distance between top of tooth on one gear to bottom of gap on another.

module gear(number_of_teeth,
    circular_pitch=false, diametral_pitch=false,
    pressure_angle=20, clearance = 0)
{
  if (circular_pitch==false && diametral_pitch==false) echo("MCAD ERROR: gear module needs either a diametral_pitch or circular_pitch");
  
  //Convert diametrial pitch to our native circular pitch
  circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);
  
  // Pitch diameter: Diameter of pitch circle.
  pitch_diameter  =  number_of_teeth * circular_pitch / 180;
  pitch_radius = pitch_diameter/2;
  
  // Base Circle
  base_diameter = pitch_diameter*cos(pressure_angle);
  base_radius = base_diameter/2;

  // Diametrial pitch: Number of teeth per unit length.
  pitch_diametrial = number_of_teeth / pitch_diameter;

  // Addendum: Radial distance from pitch circle to outside circle.
  addendum = 1/pitch_diametrial;
  
  //Outer Circle
  outer_radius = pitch_radius+addendum;
  outer_diameter = outer_radius*2;
  
  // Dedendum: Radial distance from pitch circle to root diameter
  dedendum = addendum + clearance;

  // Root diameter: Diameter of bottom of tooth spaces.
  root_radius = pitch_radius-dedendum;
  root_diameter = root_radius * 2;
  
  half_thick_angle = 360 / (4 * number_of_teeth);
  
  union() {
    rotate(half_thick_angle)
      circle($fn=number_of_teeth*2, r=root_radius*1.001);
    
    for (i= [1:number_of_teeth]) {  //for (i = [0])
      rotate([0,0,i*360/number_of_teeth]) {
        involute_gear_tooth(
          pitch_radius = pitch_radius,
          root_radius = root_radius,
          base_radius = base_radius,
          outer_radius = outer_radius,
          half_thick_angle = half_thick_angle);
      } // end of rotate(){}
    } // end of for(){}
  } // end of union(){}
} // end of module gear

module involute_gear_tooth(
          pitch_radius,
          root_radius,
          base_radius,
          outer_radius,
          half_thick_angle
          )
{
  pitch_to_base_angle  = involute_intersect_angle( base_radius, pitch_radius );
  
  outer_to_base_angle = involute_intersect_angle( base_radius, outer_radius );
  
  base1 = 0 - pitch_to_base_angle - half_thick_angle;
  pitch1 = 0 - half_thick_angle;
  outer1 = outer_to_base_angle - pitch_to_base_angle - half_thick_angle;
  
  b1 = polar_to_cartesian([ base1, base_radius ]);
  p1 = polar_to_cartesian([ pitch1, pitch_radius ]);
  o1 = polar_to_cartesian([ outer1, outer_radius ]);
  
  b2 = polar_to_cartesian([ -base1, base_radius ]);
  p2 = polar_to_cartesian([ -pitch1, pitch_radius ]);
  o2 = polar_to_cartesian([ -outer1, outer_radius ]);
  
  // set up values for ( root_radius > base_radius ) case
    pitch_to_root_angle = pitch_to_base_angle - involute_intersect_angle(base_radius, root_radius );
    root1 = pitch1 - pitch_to_root_angle;
    root2 = -pitch1 + pitch_to_root_angle;
    r1_t =  polar_to_cartesian([ root1, root_radius ]);
    r2_t =  polar_to_cartesian([ -root1, root_radius ]);
  
  // set up values for ( else ) case
    r1_f =  polar_to_cartesian([ base1, root_radius ]);
    r2_f =  polar_to_cartesian([ -base1, root_radius ]);
  
  if (root_radius > base_radius) {
    polygon( points = [
      b1, r1_t,p1,o1,o2,p2,r2_t, b2
    ], convexity = 3);
  } else {
    polygon( points = [
      r1_f, b1,p1,o1,o2,p2,b2,r2_f
    ], convexity = 3);
  }
  
}

// Mathematical Functions
//===============

// Finds the angle of the involute about the base radius at the given distance (radius) from its center.
//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

function involute_intersect_angle(base_radius, radius) = sqrt( pow(radius/base_radius,2) - 1);



// Polar coord [angle, radius] to cartesian coord [x,y]

function polar_to_cartesian(polar) = [
  polar[1]*cos(polar[0]),
  polar[1]*sin(polar[0])
];

