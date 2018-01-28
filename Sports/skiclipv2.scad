base_edge = 25.0;
base_thickness = 2.0;
height = 15.0;
spacing = 11.0;
od = 4.5;

module ski_clip()
{
    union()
    {
            cube([base_edge,base_edge,thickness], center=true);
    translate([0,0,0]) translate([0,0,thickness]) difference()
    {
        union()
        {
            translate([0,(base_edge-height)/2,0]) rotate([0,90,0]) cylinder(spacing,height/2,height/2, center=true);
            translate([0,-(base_edge-height)/2,0])  rotate([0,90,0]) cylinder(spacing,height/2,height/2, center=true);
            translate([0,0,height/4]) cube([spacing,base_edge/2,height/2], center=true);
        }
        translate([0,spacing/2,height/4]) rotate([0,90,0]) cylinder(spacing+0.1,od/2,od/2, center=true);
        translate([0,-spacing/2,height/4]) rotate([0,90,0]) cylinder(spacing+0.1,od/2,od/2, center=true);
       translate([0,0,-height/2]) cube([base_edge+2,base_edge+2,height], center=true);
    }
}
}


ski_clip();