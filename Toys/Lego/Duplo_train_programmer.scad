
$fn=300*1.0;

length = 94;
center_width = 26;
end_width = 20;
height = 8;
height_center = 3;
center_length = 39;
end_radius = 15;
centner_radius = 280;
inner_radius=5;


module bottom()
{
    difference()
    {
        union()
        {
            translate([0,0,height/2]) minkowski()
            {
                cube([length-end_radius,end_width-end_radius,height/2],center=true);
                cylinder(r=end_radius/2,h=height/2,center=true);
            }
            difference()
            {
                translate([0,centner_radius-center_width/2,height/2]) cylinder(r=centner_radius,h=height,center=true);
                translate([0,centner_radius-end_width/2,height/2]) cube([centner_radius*2,centner_radius*2,height+1],center=true);
            }
            difference()
            {
                translate([0,-centner_radius+center_width/2,height/2]) cylinder(r=centner_radius,h=height,center=true);
                translate([0,-centner_radius+end_width/2,height/2]) cube([centner_radius*2,centner_radius*2,height+1],center=true);
            }
        }
        translate([0,0,(height+height_center)/2]) difference()
        {
            cube([center_length+20,center_width,0.1+height-height_center],center=true);
            translate([(center_length+center_width)/2,0,0]) minkowski()
            {
                cube([center_width-inner_radius,center_width-inner_radius-1,height/2],center=true);
                cylinder(r=inner_radius/2,h=height/2,center=true);
            }
            translate([-(center_length+center_width)/2,0,0]) minkowski()
            {
                cube([center_width-inner_radius,center_width-inner_radius-1,height/2],center=true);
                cylinder(r=inner_radius/2,h=height/2,center=true);
            }
        }
    }
    
}

bottom();