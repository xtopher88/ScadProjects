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
    
    back_wall_height = 41.65;
    
    module shaft_cutout()
    {
        d_shaft = 4;
        d_inner = 8;
        d_wheel = 8;
        rotate([90,0,0]) cylinder(wheel_base,d_shaft/2,d_shaft/2,center=true);
        // rotate([90,0,0]) cylinder(wheel_base-10,d_inner/2,d_inner/2,center=true);
        translate([0,(wheel_base+10)/2,0]) rotate([90,0,0]) cylinder(10,d_wheel/2,d_wheel/2,center=true);
        translate([0,-(wheel_base+10)/2,0]) rotate([90,0,0]) cylinder(10,d_wheel/2,d_wheel/2,center=true);
    }
    
    module triangle_support(length,thickness)
    {
        difference()
        {
            cube([length,thickness,thickness],center=true);
            rotate([45,0,0]) translate([0,0,-thickness*sqrt(2)/2]) cube([length+.1,thickness*sqrt(2),thickness*sqrt(2)],center=true);
        }
    }
    
    difference()
    {
        union()
        {
            translate([13,(wheel_base/2+1),-6]) cube([111,6,32],center=true);
            translate([13,-(wheel_base/2+1),-6]) cube([111,6,32],center=true);
            
            translate([28,0,-19]) cube([6,16*4+4,6],center=true);
            translate([-28,0,-19]) cube([6,16*4+4,6],center=true);
            difference()
            {
                translate([-6,0,back_wall_height/2-22]) cube([6,16*4+4,back_wall_height],center=true);
                //translate([-6,0,-2]) cube([7,16*2.5,24.1],center=true);
            }
            difference()
            {
                union()
                {
                    // top and bottom duplo blocks
                    translate([16*2,0,9]) duplo_top(4,4);
                    translate([-16*2,0,9+block_height/2]) duplo_top(4,4);
                    // supports for the front blocks
                    translate([16*2-3,-24,3]) triangle_support(16*4+2,10);
                    translate([16*2-3,24,3]) rotate([-90,0,0]) triangle_support(16*4+2,10);
                }
                //remove the front of the back blocks
                translate([0,0,back_wall_height/2]) cube([6,16*4+4,10],center=true);
                //remove the center of the front blocks
                translate([16*2,0,10]) cube([16*4+4,16*2+6,10],center=true);
            }
        }
        // front and rear angled bottom
        rotate([0,39,0]) translate([-35,0,-59]) cube([main_wheel_spacing/2,16*4+10,block_height*2],center=true);
        rotate([0,-39,0]) translate([35,0,-59]) cube([main_wheel_spacing/2,16*4+10,block_height*2],center=true);
        // motor block cutout
        gear_block_height = 24.0;
        translate([-48,0,gear_block_height/2-6]) cube([40,58.5,gear_block_height],center=true);
        // drive shafts
        translate([main_wheel_spacing/2,0,6]) shaft_cutout();
        translate([idler_wheel_spacing/2,0,idler_wheel_height]) shaft_cutout();
        translate([0,0,idler_wheel_height]) shaft_cutout();
        translate([-idler_wheel_spacing/2,0,idler_wheel_height]) shaft_cutout();
        
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
    %translate([-58,0,-2+8])  rotate([0,0,180]) double_gearbox();
}
base1();