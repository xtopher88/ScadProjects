
$fn=120*1.0;


module WrapMount(width = 101, height = 24, tab1_angle=90,tab2_angle=90)
{
    thickness = 3;
    length = 10;
    tab_length = length;
    tab_hole_od = 4;
    
    module tab(tab_l=tab_length)
    {
        difference()
        {
            union()
            {
                translate([0,(tab_l/2+thickness)/2,0]) cube([thickness,tab_l/2,length], center=true);
                translate([0,(tab_l+thickness)/2,0]) rotate([0,90,0]) cylinder(thickness,tab_l/2,tab_l/2, center=true);
            }
            translate([0,(tab_l+thickness)/2,0]) rotate([0,90,0]) cylinder(thickness+0.1,tab_hole_od/2,tab_hole_od/2, center=true);
            
        }
    }
    difference()
    {
    union()
    {
        // main walls
        cube([width+thickness*2,thickness,length], center=true);
        translate([(width+thickness)/2,height/2,0]) cube([thickness,height+thickness,length], center=true);
        translate([-(width+thickness)/2,height/2,0]) cube([thickness,height+thickness,length], center=true);
        
        //tabs
        translate([-(width+thickness)/2,height,0]) rotate([0,0,tab1_angle]) tab(10);
        translate([(width+thickness)/2,height,0]) rotate([0,0,-tab2_angle]) tab();
        //translate([(width+tab_length+thickness)/2,height,0]) cube([tab_length,thickness,length], center=true);
        
        //wall base
        //translate([0,thickness/2,(length-thickness)/2]) cube([width+thickness*2,thickness*2,thickness], center=true);
        //translate([(width)/2,height/2,(length-thickness)/2]) cube([thickness*2,height+thickness,thickness], center=true);
        //translate([-(width)/2,height/2,(length-thickness)/2]) cube([thickness*2,height+thickness,thickness], center=true);
    }
        //translate([(width+tab_length+thickness)/2,height,0]) rotate([90,0,0]) cylinder(thickness+0.1,tab_hole_od/2,tab_hole_od/2, center=true);
        //translate([-(width+tab_length+thickness)/2,height,0]) rotate([90,0,0]) cylinder(thickness+0.1,tab_hole_od/2,tab_hole_od/2, center=true);
    }
}

module corner_mount(height, width, tab_length, support_width = 10,support_side=-1,thickness=4)
{
    tab_hole_od=4;
    module tab(tab_l=tab_length)
    {
        difference()
        {
            cube([thickness,tab_length+thickness,width], center=true);
            translate([0,thickness/2,0]) rotate([0,90,0]) cylinder(thickness+0.1,tab_hole_od/2,tab_hole_od/2, center=true);
        }
    }
    union()
    {
        // main wall
        cube([height+thickness,thickness,width], center=true);
        // support
        translate([0,0,support_side*(width-thickness/2)/2]) cube([height+thickness,support_width+thickness,thickness/2], center=true);
        // tabs
        translate([(height)/2,tab_length/2,0]) tab();
        translate([-(height)/2,-tab_length/2,0]) rotate(180,0,0) tab();
    }
    
}

module dvd_mount1()
{
    seporation = 79.5;
    hole_offset = 0.0;
    inset = 3.3;
    hole_od = 3.5;
    thickness = 2;
    width = 8;
    side_length = width*1.5;
    side_thickness = thickness*1.5;
    side_seporation = 100;
    base_length = side_seporation + side_length;
    difference()
    {
        union()
        {
            cube([base_length,width,thickness], center=true);
            translate([-(side_seporation)/2,(width-side_thickness)/2,(width)/2]) cube([side_length,side_thickness,width], center=true);
            translate([(side_seporation)/2,(width-side_thickness)/2,(width)/2]) cube([side_length,side_thickness,width], center=true);
        }
        translate([hole_offset+seporation/2,width/2-inset,0]) rotate([0,0,90]) cylinder(thickness+0.1,hole_od/2,hole_od/2, center=true);
        translate([hole_offset-seporation/2,width/2-inset,0]) rotate([0,0,90]) cylinder(thickness+0.1,hole_od/2,hole_od/2, center=true);
        
        translate([-(side_seporation)/2,(width-side_thickness)/2,(width)/2]) rotate([90,0,0]) cylinder(side_thickness+0.1,hole_od/2,hole_od/2, center=true);
        translate([(side_seporation)/2,(width-side_thickness)/2,(width)/2]) rotate([90,0,0]) cylinder(side_thickness+0.1,hole_od/2,hole_od/2, center=true);
    }
}

module dvd_mount2()
{
    seporation = 79.5;
    hole_offset = 0.0;
    inset = 20.0;
    hole_od = 3.5;
    thickness = 2;
    width = inset+4;
    width1 = 10;
    side_length = 15;
    side_thickness = thickness*1.5;
    side_seporation = seporation;
    base_length = side_seporation + side_length;
    difference()
    {
        union()
        {
            cube([base_length,width,thickness], center=true);
            translate([-(side_seporation)/2,(width-side_thickness)/2,(width1)/2]) cube([side_length,side_thickness,width1], center=true);
            translate([(side_seporation)/2,(width-side_thickness)/2,(width1)/2]) cube([side_length,side_thickness,width1], center=true);
        }
        translate([hole_offset+seporation/2,width/2-inset,0]) rotate([0,0,90]) cylinder(thickness+0.1,hole_od/2,hole_od/2, center=true);
        translate([hole_offset-seporation/2,width/2-inset,0]) rotate([0,0,90]) cylinder(thickness+0.1,hole_od/2,hole_od/2, center=true);
        
        translate([0,0,0]) rotate([0,0,90]) cylinder(thickness+0.1,inset/2-4,inset/2-4, center=true);
        translate([inset,0,0]) rotate([0,0,90]) cylinder(thickness+0.1,inset/2-4,inset/2-4, center=true);
        translate([-inset,0,0]) rotate([0,0,90]) cylinder(thickness+0.1,inset/2-4,inset/2-4, center=true);
        
        translate([-(side_seporation)/2,(width-side_thickness)/2,(width1)/2]) rotate([90,0,0]) cylinder(side_thickness+0.1,hole_od/2,hole_od/2, center=true);
        translate([(side_seporation)/2,(width-side_thickness)/2,(width1)/2]) rotate([90,0,0]) cylinder(side_thickness+0.1,hole_od/2,hole_od/2, center=true);
    }
}

module monitor_mount()
{
    height = 13.5;
    top_thickness = 5.0;
    overlap = 10.0;
    outside = 10.0;
    mount_d = 210;
    width = 30;
    hole_d = 4;
    hole_d1 = 7.5;
    hole_depth = 4;
    head_depth = 4;
    module mount_hole()
    {
        union()
        {
            cylinder(height+top_thickness+0.1,hole_d/2,hole_d/2, center=true);
            translate([0,0,hole_depth+head_depth]) cylinder(height+top_thickness,hole_d1/2,hole_d1/2, center=true);
            translate([0,0,hole_depth-(-head_depth+height+top_thickness)/2]) cylinder(head_depth+0.1,hole_d/2,hole_d1/2, center=true);
        }
    }
    
    difference()
    {
        union()
        {
            cube([overlap+outside,width,height+top_thickness], center=true);
            
        }
        translate([mount_d/2,0,-top_thickness/2]) cylinder(height+0.1,mount_d/2,mount_d/2, center=true);
        translate([-outside/2,width/4,0]) mount_hole();
        translate([-outside/2,-width/4,0]) mount_hole();
    }
}

monitor_mount();
//dvd_mount2();

//corner_mount(42,10,15,0);

//WrapMount();
//corner_mount(86,10,10,5);
//corner_mount(86,10,10,5,1);