id = 19.2;
od = 22;
width = 12;
difference()
{
    cylinder(width,od/2,od/2,center=true);
    cylinder(width+1,id/2,id/2,center=true);
    translate([0,width*3/4,0]) cube([id-2,id,width+1],center=true);
}