$fn=30*1.0;

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

module SwivelBlock()
{
    width = 31.8;
    length = 47.8;
    wall_thickness = 1.55;
    top_thickness = 2;
    grip_thickness = 2.1;
    center_thickness = 8.0;
    center_od = 10;
    grip_od = 6.5;
    grip_id = 4.9;
    grip_spacing = 8.0;
    module grip_circle()
    {
        difference()
        {
            cylinder(grip_thickness+top_thickness,grip_od/2,grip_od/2,center=true);
            cylinder(grip_thickness+top_thickness+0.1,grip_id/2,grip_id/2,center=true);
        }
    }
    difference(){
    union()
    {
        translate([0,0,Height/4]) cylinder(Height,center_od/2,center_od/2,center=true);
        difference()
        {
            cube([width,length,grip_thickness+top_thickness],center=true);
            translate([0,0,grip_thickness/2]) cube([width-2*wall_thickness,length-2*wall_thickness,grip_thickness],center=true);
        }
        for(i=[-2:2])
        {
            for(j=[-1:1])
            {
                translate([grip_spacing*j,grip_spacing*i,0]) grip_circle();
            }
        }
    }
    translate([0,0,1.9]) technic_cutout();
    }
}

module technic_cutout1()
{
    add=1;
    union()
    {
        translate([0,0,-add-(Height-Depth+0.1)/2]) cylinder(r=Radius2,h=Depth+0.1+add, center=true);
        cylinder(r=Radius1,h=Height+0.1, center=true);
        translate([0,0,add+(Height-Depth+0.1)/2]) cylinder(r=Radius2,h=Depth+0.1+add, center=true);
    }
}
//SwivelBlock();
module SwivelBlock1()
{
    blength=31.7;
    bwidth=blength/2;
    bthickness=9.6;
    spacing = 8;
    difference()
    {
        cube([bwidth,blength,bthickness],center=true);
        for(j=[-1,1])
        {
            translate([(bwidth-Height)/2,spacing*j,0]) rotate([0,90,0]) technic_cutout1();
            translate([-(bwidth-Height)/2,spacing*j,0]) rotate([0,90,0]) technic_cutout1();
        }
        translate([0,0,(bthickness-Height)/2]) technic_cutout1();
    }
}
SwivelBlock1();