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


module SegmentBeam(end1=3,middle=10,end2=2)
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



module angle_section(radius,height,thickness, angle=90)
{
    difference()
    {
        cylinder(r=radius,h=height, center=true);
        cylinder(r=radius-thickness,h=height+0.1, center=true);
        rotate([0,0,(180-angle)/2]) translate([0,radius/2,0]) cube([radius*2,radius,height+0.1],center=true);
        rotate([0,0,-(180-angle)/2])  translate([0,radius/2,0]) cube([radius*2,radius,height+0.1],center=true);
    }
}


module pie_slice(radius,thickness, angle=90)
{
    difference()
    {
        cylinder(r=radius,h=thickness, center=true);
        rotate([0,0,(180-angle)/2]) translate([0,radius/2,0]) cube([radius*2,radius,thickness+0.1],center=true);
        rotate([0,0,-(180-angle)/2]) translate([0,radius/2,0]) cube([radius*2,radius,thickness+0.1],center=true);
    }
}


module wheel_support1()
{
    length_h = 18;
    length_base = 10;
    support_angle = asin((length_base/2)/length_h);
    echo(support_angle);
    difference()
    {
        union()
        {
            cylinder(r=Pitch,h=Height, center=true);
            translate([0,Pitch/2,0]) pie_slice(Pitch*4,Height,support_angle);
            rotate([0,0,support_angle-90]) beam(length_h+1);
            rotate([0,0,-support_angle-90]) beam(length_h+1);
            translate([-(length_base)*Pitch/2,-length_h*Pitch*cos(support_angle),0]) beam(length_base+1);
            
        }
        drawBeamHoles(1);
        rotate([0,0,support_angle-90]) translate([Pitch*3,0,0]) drawBeamHoles(8);
        rotate([0,0,-support_angle-90]) translate([Pitch*3,0,0]) drawBeamHoles(8);
        translate([-(length_base-2)*Pitch/2,-length_h*Pitch*cos(support_angle),0]) drawBeamHoles(length_base-1);
    }
}


wheel_support1();

//SegmentBeam();