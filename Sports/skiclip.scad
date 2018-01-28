
width = 20.0;
length = 40.0;
thickness = 3.0;

clip_width = 20;
clip_id = 12.0;
clip_od = 20;

module ski_clip()
{
    union()
    {
            cube([width,length,thickness], center=true);
    translate([0,0,thickness]) difference()
    {
        union()
        {
            rotate([0,90,0]) cylinder(clip_width,clip_od/2,clip_od/2, center=true);
        }
        rotate([0,90,0]) cylinder(clip_width+0.1,clip_id/2,clip_id/2, center=true);
        translate([0,0,-clip_width/2-thickness]) cube([clip_width+0.1,clip_od,clip_width], center=true);
    }
}
}


ski_clip();