//use <flexbatter.scad>;

track_inner_width = 5.8;
track_outter_width = 10.8;
shaft_length = 8.5;
shaft_d1 = 6.2;
shaft_d2 = 6.6;

module wheel_base(diameter)
{
    d_outer = diameter - 2.8;
    d_inner = diameter;
    difference()
    {
        union()
        {
            translate([0,0,shaft_length+track_outter_width/2]) cylinder(track_inner_width,d_inner/2,d_inner/2,center=true);
            translate([0,0,shaft_length+track_outter_width/2]) cylinder(track_outter_width,d_outer/2,d_outer/2,center=true);
            translate([0,0,shaft_length/2]) cylinder(shaft_length,shaft_d1/2,shaft_d2/2,center=true);
        }
    }
}

module W1()
{
    wheel_base(11);
}

module W2()
{
    wheel_base(21.8);
}

module W3()
{
    wheel_base(21.8);
}

module W4()
{
    wheel_base(31.8);
}

module W5()
{
    wheel_base(31.8);
}

module double_gearbox()
{
    gear_block_width = 57.5;
    gear_block_height = 23.0;
    gear_block_length = 40.0;
    motor_width = 39.0;
    total_length = 69.0;
    drive_shaft_offset = 14.0;
    mount_offset = 20.0;
    mount_width = 67.0;
    
    shaft_diameter = 2.8;
    shaft_length = 100.0;
    union()
    {
        rotate([90,0,0]) cylinder(shaft_length,shaft_diameter/2,shaft_diameter/2,center=true);
        translate([-gear_block_length/2+drive_shaft_offset,0,0]) cube([gear_block_length,gear_block_width,gear_block_height],center=true);
        translate([-total_length/2+drive_shaft_offset,0,0]) cube([total_length,motor_width,gear_block_height],center=true);
        difference()
        {
            translate([-mount_offset+drive_shaft_offset,0,-(gear_block_height-2)/2]) cube([8,mount_width,2],center=true);
            translate([-mount_offset+drive_shaft_offset,0,-(gear_block_height-2)/2]) cube([4,mount_width-4,2.5],center=true);
        }
    }
}

module duplo_nipple(outer = 9.35, inner = 6.93, height = 4.5)
{
  difference()
  {
    cylinder(height,outer/2,outer/2,center=true);
    cylinder(height+1,inner/2,inner/2,center=true);
  }
}

module duplo_top(x = 2, y = 4, thickness = 2)
{
  spacing = 16.0; 
  parimeter = 3.2+9.35/2;
  height = 4.5;
    
  union()
  {
    for (i = [0:x-1]) 
    {
      for (j = [0:y-1])
      {
        translate([((i-(x-1)/2)*spacing),((j-(y-1)/2)*spacing),(height+thickness)/2]) duplo_nipple();
      }
    }
    cube([(x-1)*spacing+2*parimeter,(y-1)*spacing+2*parimeter,thickness],center=true);
  }
}

module duplo_block(n_width,n_length,thickness)
{
    duplo_top(n_length, n_width, thickness);
}

module aa()
{
    length = 51;
    diameter = 14.2;
    cylinder(length,diameter/2,diameter/2,center=true);
}


module base1()
{
    wheel_base = 60.0;
    main_wheel_spacing = 128;
    idler_wheel_spacing = 68;
    idler_wheel_height = -18;
    block_height = 19.3;
    shaft_diameter = 3.0;
    
    //translate([10,-9,-6]) flexbatterAAx2();
    
    module shaft_cutout()
    {
        d_shaft = 4;
        d_inner = 8;
        d_wheel = 8;
        rotate([90,0,0]) cylinder(wheel_base,d_shaft/2,d_shaft/2,center=true);
        rotate([90,0,0]) cylinder(wheel_base-10,d_inner/2,d_inner/2,center=true);
        translate([0,(wheel_base+10)/2,0]) rotate([90,0,0]) cylinder(10,d_wheel/2,d_wheel/2,center=true);
        translate([0,-(wheel_base+10)/2,0]) rotate([90,0,0]) cylinder(10,d_wheel/2,d_wheel/2,center=true);
    }
    %translate([30,16/2,8]) rotate([0,90,0]) aa();
    %translate([30,-16/2,8]) rotate([0,90,0]) aa();
    //translate([-58,0,-2+8])  rotate([0,180,0]) double_gearbox();
    
    difference()
    {
        union()
        {
            translate([16*2,0,15-5/2]) duplo_block(4,4,5);
            translate([-16*2,0,15+(block_height/2-5)/2]) duplo_block(4,4,5+block_height/2);
            translate([0,0,15-5/2]) cube([16*4,16*4,5],center=true);
            // screw suports
            translate([-54,(screw_spacing-5-6)/2,20.9]) cube([20,20,7.5],center=true);
            translate([-54,-(screw_spacing-5-6)/2,20.9]) cube([20,20,7.5],center=true);
            // front and rear bumper
            d_bumper = 5;
            translate([64,0,idler_wheel_height+33-d_bumper]) rotate([90,0,0]) cylinder(16*4,d_bumper,d_bumper,center=true);
            translate([64,0,idler_wheel_height+24-d_bumper]) cube([d_bumper*2,16*4,block_height],center=true);
            // side rails
            //translate([10,wheel_base/2-3,-7]) cube([105,10,35],center=true);
            //translate([10,-wheel_base/2+3,-7]) cube([105,10,35],center=true);
            translate([10,0,-7]) cube([105,16*4,35],center=true);
        }
        // front and rear angled bottom
        translate([-75,0,idler_wheel_height+7]) rotate([0,35,0]) cube([main_wheel_spacing,16*4+1,block_height],center=true);
        translate([75,0,idler_wheel_height+7]) rotate([0,-35,0]) cube([main_wheel_spacing,16*4+1,block_height],center=true);
        // motor block cutout
        motor_width = 41.0;
        gear_block_height = 24.0;
        translate([-39,0,gear_block_height/2-6]) cube([80,motor_width,gear_block_height],center=true);
        translate([-55,0,gear_block_height/2-6]) cube([25,16*4+10,gear_block_height],center=true);
        translate([-52,0,gear_block_height/2-6]) cube([40,58.5,gear_block_height],center=true);
        // motor screw cutout
        screw_spacing = 58.5;
        screw_diameter = 4;
        translate([-55,screw_spacing/2,20]) cube([15,screw_diameter,20],center=true);
        translate([-55,-screw_spacing/2,20]) cube([15,screw_diameter,20],center=true);
        translate([-55,(screw_spacing-5-6)/2,27.15]) cube([15,20,5],center=true);
        translate([-55,-(screw_spacing-5-6)/2,27.15]) cube([15,20,5],center=true);
        // drive shafts
        //%translate([main_wheel_spacing/2-7,0,-2]) shaft_cutout();
        translate([main_wheel_spacing/2,0,6]) shaft_cutout();
        translate([idler_wheel_spacing/2,0,idler_wheel_height]) shaft_cutout();
        translate([0,0,idler_wheel_height]) shaft_cutout();
        translate([-idler_wheel_spacing/2,0,idler_wheel_height]) shaft_cutout();
        // battery compartment
        translate([30.5,0,20]) cube([61,16*2,10],center=true);
        length = 51;
    diameter = 14.2;
        translate([31,16/2,7]) union()
        {
            rotate([0,90,0]) cylinder(55,15/2,15/2,center=true);
            translate([0,0,15/2]) cube([54,15,15],center=true);
        }
        translate([31,-16/2,7]) union()
        {
            rotate([0,90,0]) cylinder(55,15/2,15/2,center=true);
            translate([0,0,15/2]) cube([54,15,15],center=true);
        }
        translate([31,0,13]) cube([55,15,8],center=true);
        %translate([30,16/2,7]) rotate([0,90,0]) aa();
        %translate([30,-16/2,7]) rotate([0,90,0]) aa();
    }
    
    module wheels()
    {
        // wheel locations
        translate([main_wheel_spacing/2-7,-wheel_base/2,-2]) rotate([90,0,0]) W4();
        translate([main_wheel_spacing/2-7,wheel_base/2,-2]) rotate([-90,0,0]) W4();
        translate([-main_wheel_spacing/2+5,-wheel_base/2,-3]) rotate([90,0,0]) W4();
        translate([-main_wheel_spacing/2+5,wheel_base/2,-3]) rotate([-90,0,0]) W4();
        translate([idler_wheel_spacing/2,wheel_base/2,idler_wheel_height]) rotate([-90,0,0]) W3();
        translate([0,wheel_base/2,idler_wheel_height]) rotate([-90,0,0]) W3();
        translate([-idler_wheel_spacing/2,wheel_base/2,idler_wheel_height]) rotate([-90,0,0]) W3();
        translate([idler_wheel_spacing/2,-wheel_base/2,idler_wheel_height]) rotate([90,0,0]) W3();
        translate([0,-wheel_base/2,idler_wheel_height]) rotate([90,0,0]) W3();
        translate([-idler_wheel_spacing/2,-wheel_base/2,idler_wheel_height]) rotate([90,0,0]) W3();
    }
    //%wheels();
}
base1();