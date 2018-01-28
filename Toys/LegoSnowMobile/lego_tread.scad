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


module drawBeam(Holes = 9)
{
    Length = (Holes-1) * Pitch;
    difference()
    {
	    union()
	    {			
            translate([Length/2,0,0]) cube([Length, Width, Height], center=true);
            cylinder(r=Width/2, h=Height, center=true);
            translate([(Holes-1)*Pitch, 0,0]) cylinder(r=Width/2, h=Height, center=true);
	    }
        for (i = [1:Holes])
        {
             translate([(i-1)*Pitch, 0,0]) technic_cutout();
        }
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


RadiusSmall = 3.8/2;
module drawBeamSmall(Holes = 9)
{
    Length = (Holes-1) * Pitch;
    difference()
    {
	    union()
	    {			
            translate([Length/2,0,0]) cube([Length, Width, Height], center=true);
            cylinder(r=Width/2, h=Height, center=true);
            translate([(Holes-1)*Pitch, 0,0]) cylinder(r=Width/2, h=Height, center=true);
	    }
        for (i = [1:Holes])
        {
             translate([(i-1)*Pitch, 0,0]) cylinder(r=RadiusSmall,h=Height+0.1, center=true);;
        }
    }
}

rod_od = 6.0;
rod_id = 3.2;

module treadBeam(Holes = 9)
{
    Length = (Holes-1) * Pitch;
    difference()
    {
	    union()
	    {			
            translate([Length/2,0,0]) cube([Length, Width, Height], center=true);
            cylinder(r=Width/2, h=Height, center=true);
            translate([(Holes-1)*Pitch, 0,0]) cylinder(r=Width/2, h=Height, center=true);
            
            translate([Length/2,rod_id,0]) cube([Length-Pitch, Width, Height], center=true);
            for (i = [1:Holes-1])
            {
                translate([(i-1)*Pitch+Pitch/2, (Width+rod_id)/2,0]) cylinder(r=rod_od/2, h=Height, center=true);
            }
	    }
        for (i = [1:Holes])
        {
             translate([(i-1)*Pitch, 0,0]) technic_cutout();
        }
        for (i = [1:Holes])
        {
             translate([(i-1)*Pitch+Pitch/2,  (Width+rod_id)/2,0])cylinder(r=rod_id/2, h=Height+0.1, center=true);
        }
    }
}

module tread_side()
{
    angle = 41.41;
    num_pitch = 2.6457513;
    difference()
    {
        union()
        {
            translate([-Pitch*3,-Pitch*num_pitch,0]) drawBeam(15);
            treadBeam(9);
            rotate([0,0,angle]) translate([-Pitch*4,0,0]) union()
            {
                treadBeam(5);
                translate([1*Pitch, 0,0]) cylinder(r=Width/2, h=Height, center=true);
            }
            translate([Pitch*8,0,0]) rotate([0,0,-angle])
            {
                treadBeam(5);
                translate([3*Pitch, 0,0]) cylinder(r=Width/2, h=Height, center=true);
            }
        }
        translate([-Pitch*2,-Pitch*num_pitch,0]) technic_cutout();
        translate([Pitch*10,-Pitch*num_pitch,0]) technic_cutout();
    }
}


module tread_side1()
{
    angle = 36.86989764584402;
    num_pitch = 3;
    difference()
    {
        union()
        {
            translate([-Pitch*4,-Pitch*num_pitch,0]) drawBeam(17);
            treadBeam(9);
            rotate([0,0,angle]) translate([-Pitch*5,0,0]) union()
            {
                treadBeam(6);
                translate([1*Pitch, 0,0]) cylinder(r=Width/2, h=Height, center=true);
            }
            translate([Pitch*8,0,0]) rotate([0,0,-angle])
            {
                treadBeam(6);
                translate([4*Pitch, 0,0]) cylinder(r=Width/2, h=Height, center=true);
            }
        }
        translate([-Pitch*3,-Pitch*num_pitch,0]) technic_cutout();
        translate([Pitch*11,-Pitch*num_pitch,0]) technic_cutout();
    }
}


module tread_side2()
{
    angle = 36.86989764584402;
    num_pitch = 3;
    difference()
    {
        union()
        {
            // Top Beam
            translate([-Pitch*4,-Pitch*num_pitch,0]) drawBeam(17);
            // bottom beam
            drawBeam(9);
            // end beams
            rotate([0,0,angle]) translate([-Pitch*5,0,0]) union() drawBeamSmall(6);
            translate([Pitch*8,0,0]) rotate([0,0,-angle]) drawBeamSmall(6);
            // additional holes
            translate([-Pitch*3,-Pitch*num_pitch,0]) cylinder(r=Width/2, h=Height, center=true);
            translate([Pitch*11,-Pitch*num_pitch,0]) cylinder(r=Width/2, h=Height, center=true);
            translate([Pitch*4,0,0])  cylinder(r=Width/2, h=Height, center=true);
        }
        
        rotate([0,0,angle]) translate([-Pitch*5,0,0]) translate([1*Pitch, 0,0]) cylinder(r=RadiusSmall, h=Height+0.1, center=true);
        translate([Pitch*8,0,0]) rotate([0,0,-angle]) translate([4*Pitch, 0,0]) cylinder(r=RadiusSmall, h=Height+0.1, center=true);
        translate([Pitch*4,0,0])  cylinder(r=RadiusSmall, h=Height+0.1, center=true);
        //translate([-Pitch*3,-Pitch*num_pitch,0]) technic_cutout();
        //translate([Pitch*11,-Pitch*num_pitch,0]) technic_cutout();
    }
}

wheel_od1 = 8.5;
wheel_od2 = 7;
wheel_center = 1.8;
side_height = (Height-wheel_center)/2;

module small_wheel()
{
    difference()
    {
        union()
        {
            cylinder(r=wheel_od2/2, h=Height, center=true);
            translate([0,0,(side_height/2+wheel_center)/2]) cylinder(side_height/2, wheel_od2/2, wheel_od1/2, center=true);
            translate([0,0,-(side_height/2+wheel_center)/2]) cylinder(side_height/2, wheel_od1/2, wheel_od2/2, center=true);
            translate([0,0,(side_height*3/2+wheel_center)/2]) cylinder(side_height/2, wheel_od1/2, wheel_od1/2, center=true);
            translate([0,0,-(side_height*3/2+wheel_center)/2]) cylinder(side_height/2, wheel_od1/2, wheel_od1/2, center=true);
        }
        technic_cutout();
    }
}

module snowmobile_tread()
{
    angle = 36.86989764584402;
    num_pitch = 3;
    difference()
    {
        union()
        {
            drawBeam(10);
            rotate([0,0,angle]) translate([-Pitch*5,0,0]) drawBeam(6);
            translate([-Pitch*11,-Pitch*3,0]) drawBeam(8);
            translate([-Pitch*11,-Pitch*7,0]) rotate([0,0,90]) drawBeam(5);
            translate([-Pitch*4,-Pitch*7,0]) rotate([0,0,90]) drawBeam(5);
            translate([-Pitch*11,-Pitch*7,0]) drawBeam(8);
            translate([-Pitch*4,-Pitch*5,0]) drawBeam(12);
            translate([Pitch*1,-Pitch*5,0]) rotate([0,0,90]) drawBeam(6);
        }
    }
}

module cross_brace(brace_width=7.8*5)
{
    Radius3 = 6.0/2;
    union()
    {
        translate([0,0,(brace_width-Width)/2]) drawBeam(4);
        translate([0,0,-(brace_width-Width)/2]) drawBeam(4);
        translate([Pitch*3/2,0,0]) difference()
        {
            union()
            {
                cube([Pitch*3,Width,brace_width-Width*2],center=true);
                translate([(1.5)*Pitch, 0,0]) cylinder(r=Width/2, h=brace_width-Width*2, center=true);
                translate([(-1.5)*Pitch, 0,0]) cylinder(r=Width/2, h=brace_width-Width*2, center=true);
            }
            translate([(1.5)*Pitch, 0,0]) cylinder(r=Radius3,h=brace_width, center=true);
            translate([-(1.5)*Pitch, 0,0]) cylinder(r=Radius3,h=brace_width, center=true);
            translate([(0.5)*Pitch, 0,0]) cylinder(r=Radius3,h=brace_width, center=true);
            translate([-(0.5)*Pitch, 0,0]) cylinder(r=Radius3,h=brace_width, center=true);
        }
    }
}

module cross_brace2(brace_width=7.8*5)
{
    Radius3 = 6.0/2;
    union()
    {
        translate([0,0,(brace_width-Width)/2]) drawBeam(2);
        translate([0,0,-(brace_width-Width)/2]) drawBeam(2);
        translate([Pitch*1/2,0,0]) difference()
        {
            union()
            {
                cube([Pitch*1,Width,brace_width-Width*2],center=true);
                translate([(0.5)*Pitch, 0,0]) cylinder(r=Width/2, h=brace_width-Width*2, center=true);
                translate([(-0.5)*Pitch, 0,0]) cylinder(r=Width/2, h=brace_width-Width*2, center=true);
            }
            translate([(0.5)*Pitch, 0,0]) cylinder(r=Radius3,h=brace_width, center=true);
            translate([-(0.5)*Pitch, 0,0]) cylinder(r=Radius3,h=brace_width, center=true);
        }
    }
}

module angle_spacer()
{
    spacing = 5;
    translate([0,0,Width*spacing/2]) drawBeam(3);
    translate([0,0,-Width*spacing/2]) drawBeam(3);
    Holes = 4;
    difference()
    {
        translate([Pitch*2/2,0,0]) cube([Pitch, Width, Pitch*5-4], center=true);
        translate([Pitch,0,Pitch*2/2]) rotate([90,90,0]) drawBeamHoles(3);
        translate([0,0,Width*spacing/2]) drawBeamHoles(3);
        translate([0,0,-Width*spacing/2]) drawBeamHoles(3);
        //translate([Pitch*2,0,Pitch*3/2]) rotate([90,90,0]) drawBeamHoles(4);
    }
}

//tread_side2();
//small_wheel();

snowmobile_tread();
//cross_brace();
//cross_brace2();
//angle_spacer();