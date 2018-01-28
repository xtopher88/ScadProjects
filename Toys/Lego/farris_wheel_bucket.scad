

$fn=30*1.0;

// inner seat placement information
inner_length = 48.0 + 0.5;
inner_width = 15.9 + 1.0;
depth = 14.0;

// bucket dimmensions
total_width = 24.0;
bottom_radius = 18.0;
bottom_spacing = 16;

//bucket top settings
top_angle = 71;
top_radius_add = 15;
top_thickness = 8;
top_width = 4;

//hole setting
hole_radius = 5.5/2;
hole_radius1 = 10/2;
hole_height = 42;

module half_cylinder(radius,height,flip=-1)
{
    difference()
    {
        cylinder(r=radius,h=height, center=true);
        translate([0,flip*radius/2,0]) cube([radius*2,radius,height+0.1],center=true);
    }
}


module angle_section(radius,height,thickness, angle=90)
{
    difference()
    {
        cylinder(r=radius,h=height, center=true);
        cylinder(r=radius-thickness,h=height+0.1, center=true);
        translate([0,radius/2,0]) cube([radius*2,radius,height+0.1],center=true);
        rotate([0,0,180-angle]) translate([0,radius/2,0]) cube([radius*2,radius,height+0.1],center=true);
    }
}

module bucket()
{
    
    difference()
    {
        union()
        {
            // bottom section
            translate([bottom_spacing,0,0]) half_cylinder(bottom_radius,total_width);
            translate([-bottom_spacing,0,0]) half_cylinder(bottom_radius,total_width);
            translate([0,bottom_radius/2,0]) cube([bottom_spacing*2,bottom_radius,total_width],center=true);
            // top section
            translate([-top_radius_add,0,-(total_width-top_thickness/2)/2]) angle_section(bottom_radius+bottom_spacing+top_radius_add,top_width,top_thickness,top_angle);
            translate([0,0,-(total_width-top_thickness/2)/2]) rotate([0,180,0]) translate([-top_radius_add,0,0]) angle_section(bottom_radius+bottom_spacing+top_radius_add,top_width,top_thickness,top_angle);
            // hole cutout
            translate([0,-hole_height,0]) cylinder(r=hole_radius1,h=total_width, center=true);
        }
        //seat cutout
        translate([0,depth/2,0]) cube([inner_length,depth+0.1,inner_width],center=true);
        // seat door cutout
        translate([0,depth/2-2,5]) cube([inner_length,depth+0.1,inner_width],center=true);
        // hole cutout
        translate([0,-hole_height,0]) cylinder(r=hole_radius,h=total_width+0.1, center=true);
        half_cylinder(bottom_radius+bottom_spacing-8,total_width+0.1,1);
    }
    
}

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



module beam(Holes = 9, thickness = Height)
{
    Length = (Holes-1) * Pitch;
    union()
	{			
        translate([Length/2,0,0]) cube([Length, Width, thickness], center=true);
        cylinder(r=Width/2, h=thickness, center=true);
        translate([(Holes-1)*Pitch, 0,0]) cylinder(r=Width/2, h=thickness, center=true);
	}
}
module drawBeamHoles(Holes = 9)
{
    for (i = [1:Holes])
    {
        translate([(i-1)*Pitch, 0,0]) technic_cutout();
    }
}


module drawBeam(Holes = 9)
{
    Length = (Holes-1) * Pitch;
    difference()
    {
        beam(Holes);
        drawBeamHoles(Holes);
    }
}


module SegmentBeam(end1=3,middle=7,end2=1)
{
    difference()
    {
        union()
        {
            translate([0,0,-Height/4]) beam(end1+middle+end2, Height/2);
            beam(end1, Height);
            translate([(end1+middle)*Pitch,0,0]) beam(end2, Height);
        }
        drawBeamHoles(end1);
        translate([(end1+middle)*Pitch,0,0]) drawBeamHoles(end2);
    }
}
bucket();