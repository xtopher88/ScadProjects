$fn=200;
include <MCAD/involute_gears.scad>; 
include <MCAD/regular_shapes.scad>;

//10.95 = radius;

// Number of teeth determines radius
teeth=11;

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
	bore_diameter=4,
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
	bore_diameter=4,
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
        Lgear();
        difference()
        {
            cylinder(r1=7/2,r2=7/2,h=height*2,center=true);
            //translate([6,0,0]) cube([7,7,height*2],center=true);
        }
    }
}



gearring();
//translate([0,0, -(height/2)-.1]) hexagon_prism(4.1,4.7); //Nut Trap hole

