$fn=200;
include <MCAD/involute_gears.scad>; 
include <MCAD/regular_shapes.scad>;

//10.95 = radius;

// Number of teeth determines radius
teeth=60;

// fixed pitch 
pitch = 400;

gap = 0;

circles=0;

twist=200;
height=20;
pressure_angle=30;
dia = pitch * (teeth /180);

echo(dia);

module Lgear() {

//Left gear - Bearing and hex nut trap
gear (number_of_teeth=teeth,
	circular_pitch=pitch,
	pressure_angle=pressure_angle,
	clearance = 0.2,
	gear_thickness = height/2,
	rim_thickness = height/2,
	rim_width = 2,
	hub_thickness = height/2,
	hub_diameter=9,
	bore_diameter=6,
	circles=circles,
	twist=twist/teeth,
	circle_facets=3,
	involute_facets=6);
	
mirror([0,0,1])
gear (number_of_teeth=teeth,
	circular_pitch=pitch,
	pressure_angle=pressure_angle,
	clearance = 0.2,
	gear_thickness = height/2,
	rim_thickness = height/2,
	rim_width = 2,
	hub_thickness = height/2,
	hub_diameter=9,
	bore_diameter=6,
	circles=circles,
	twist=twist/teeth,
	circle_facets=3,
	involute_facets=6);
}

module Rgear() {
//Right Gear	 - Stepper Gear
mirror ([0,1,0])
translate ([dia+gap,0,0])
gear (number_of_teeth=teeth,
	circular_pitch=pitch,
	pressure_angle=pressure_angle,
	clearance = 0.2,
	gear_thickness = height/2*0.5,
	rim_thickness = height/2,
	rim_width = 2,
	hub_thickness = height/2,
	hub_diameter=15,
	bore_diameter=5.2,
	circles=circles,
	twist=twist/teeth,
	circle_facets=3,
	involute_facets=6);

mirror ([0,1,0])
translate ([dia+gap,0,0])	
mirror([0,0,1])
gear (number_of_teeth=teeth,
	circular_pitch=pitch,
	pressure_angle=pressure_angle,
	clearance = 0.2,
	gear_thickness = height/2,
	rim_thickness = height/2,
	rim_width = 2,
	hub_thickness = height/2,
	hub_diameter=9,
	bore_diameter=5.2,
	circles=circles,
	twist=twist/teeth,
	circle_facets=3,
	involute_facets=6);
}


ring_thickness = 10;
sphear_r = 508;
mount_r = dia/2 - 5;

module bearing_cutout()
{
    
    od_pipe = 33.3;
    id_pipe = 25.6;
    od_bearing = 22.0 + 0.6;
    od1_bearing = 19.0;
    pipe_lip = 2.0;
    bearing_depth = 7.5;
    bearing_lip = 2.0;
    bearing_lip_slope = 1.5;
    union()
    {
        translate([0,0,bearing_lip/2]) cylinder(r1=od_bearing/2,r2=od_bearing/2,h=bearing_depth+0.1,center=true);
        translate([0,0,-(bearing_depth-bearing_lip_slope)/2]) cylinder(r1=od_bearing/2-bearing_lip_slope,r2=od_bearing/2,h=bearing_lip/2,center=true);
    }
}


module gearring()
{
    difference()
    {
    union()
    {
        difference()
        {
            Lgear();
            cylinder(height,dia/2-ring_thickness,dia/2-ring_thickness);
            mirror([0,0,1]) cylinder(height,dia/2-ring_thickness,dia/2-ring_thickness);
        }
        translate([0,0,-sphear_r+25]) difference()
        {
            sphere(r=sphear_r);
            difference()
            {
                sphere(r=sphear_r+1);
                cylinder(sphear_r*2,mount_r,mount_r, center=true);
            }
            translate([0,0,-height*2+5]) cylinder(sphear_r*2,mount_r+1,mount_r+1, center=true);
        }
        
        
    }
    translate([0,0,height+1]) bearing_cutout();
    translate([0,0,-7]) mirror([0,0,1]) bearing_cutout();
    cylinder(height*2,8,8, center=true);
    }
}



gearring();
//translate([0,0, -(height/2)-.1]) hexagon_prism(4.1,4.7); //Nut Trap hole

