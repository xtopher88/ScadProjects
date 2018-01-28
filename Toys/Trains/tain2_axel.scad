


module duplo_nipple(outer = 9.35, inner = 6.93, height = 4.5)
{
  difference()
  {
    cylinder(height,outer/2,outer/2,center=true);
    cylinder(height+1,inner/2,inner/2,center=true);
  }
}

module duplo_top(x = 2, y = 4, spacing = 16.0, parimeter = 3.2+9.35/2, height = 4.5, thickness = 2)
{
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

module half_hook(inner_offset=0.2)
{
  outer_diameter = 18.0;
  thickness = 5.5;
  inner_diameter = 7.8+inner_offset;
  wall_thinkness = (outer_diameter-inner_diameter)/2;
  difference()
  {
    union()
    {
      difference()
      {
        cylinder(thickness,outer_diameter/2,outer_diameter/2,center=true);
        translate([(outer_diameter)/4,0,0]) cube([outer_diameter/2,outer_diameter,thickness+1],center=true);
      }
      translate([0,(inner_diameter/2+wall_thinkness/2),0]) cylinder(thickness,wall_thinkness/2,wall_thinkness/2,center=true);
    }
    cylinder(thickness+1,inner_diameter/2,inner_diameter/2,center=true);
    translate([0,0,-(thickness*3+0.1)/8]) cylinder(thickness/4,(inner_diameter+3)/2,inner_diameter/2,center=true);
    translate([0,0,(thickness*3+0.1)/8]) cylinder(thickness/4,inner_diameter/2,(inner_diameter+3)/2,center=true);
  
  }
}

module hook_1()
{
  angle = 50;
  attach_width = 4;
  attach_length = 13;
  attach_thickness = 5.5;
  union()
  {
    rotate([0,0,angle]) half_hook();
    rotate([0,0,-angle]) rotate([0,180,0]) half_hook();
    translate([0,-7.5,0])  cube([attach_length,attach_width,attach_thickness],center=true);
  }
  //%cube([6.35,20,6],center=true);
}

module hook_2()
{
  hook_diameter = 7.0;
  latch_diameter = 7.8;
  latch_thickness = 2.3;
  height = 16;
  base_thinkness = 7.0;
  attach_width = 11;
  attach_length = 13;
  attach_thickness = 5.5;
  translate([0,0,-1.5]) 
  union()
  {
    cylinder(height,hook_diameter/2,hook_diameter/2,center=true);
    translate([0,0,(height-latch_thickness)/2]) 
    difference()
    {
      cylinder(latch_thickness,latch_diameter/2,latch_diameter/2,center=true);
      translate([0,latch_diameter/4,0]) cube([latch_diameter,latch_diameter/2,latch_thickness+1],center=true);
    }
    translate([0,4.5,-(height-attach_thickness)/2])  
    difference()
    {
      cube([attach_length,attach_width,attach_thickness],center=true);
      translate([-8.5,0,0]) rotate([0,0,18]) cube([attach_length/2,attach_width*2,attach_thickness+1],center=true);
      translate([8.5,0,0]) rotate([0,0,-18]) cube([attach_length/2,attach_width*2,attach_thickness+1],center=true);
    
    }
  }
}

module wheels()
{
  wheel_diameter = 22;
  thinkness = 3.5;
  center_thinkness = 5;
  center_diameter = 10;
  hole = 7.2;
  difference()
  {
    union()
    {
      translate([0,0,-(center_thinkness-thinkness)/2]) cylinder(thinkness,wheel_diameter/2,wheel_diameter/2,center=true);
      cylinder(center_thinkness,center_diameter/2,center_diameter/2,center=true);
    }
    cylinder(center_thinkness+1,hole/2,hole/2,center=true);
  }
}

module bolt(diameter = 6)
{
  length = 17;
  keeper_length = 10;
  keeper_thickness = 2;
  union()
  {
    cylinder(length,diameter/2,diameter/2,center=true);
    translate([0,0,(length-keeper_thickness)/2]) 
    difference()
    {
      cylinder(keeper_thickness,keeper_length/2,keeper_length/2,center=true);
      translate([0,-5.85,0]) cube([keeper_length,diameter,keeper_thickness+1],center=true);
    }
  }
}

module train_car(hook_support = 1, length = 63.75, wheel_length = 40, width = 31.75, height = 20, hole = 6.0)
{
  wheel_well = 26;
  well_depth = (width - 19)/2;
  difference()
  {
    union()
    {
      cube([width,length,height],center=true);
      translate([0,0,(height-2)/2]) duplo_top();
    }
    
    //translate([0,wheel_length/2,-5]) rotate([0,90,0]) cylinder(width,hole/2,hole/2,center=true);
    //translate([0,-wheel_length/2,-5]) rotate([0,90,0]) cylinder(width,hole/2,hole/2,center=true);
    translate([9.5,wheel_length/2,-5]) rotate([90,0,0]) rotate([0,90,0]) bolt(hole);
    translate([-9.5,wheel_length/2,-5]) rotate([90,0,0]) rotate([0,-90,0]) bolt(hole);
    translate([9.5,-wheel_length/2,-5]) rotate([90,0,0]) rotate([0,90,0]) bolt(hole);
    translate([-9.5,-wheel_length/2,-5]) rotate([90,0,0]) rotate([0,-90,0]) bolt(hole);
    
    %translate([9.5,wheel_length/2,-5]) rotate([90,0,0]) rotate([0,90,0]) bolt(hole);
    %translate([-9.5,wheel_length/2,-5]) rotate([90,0,0]) rotate([0,-90,0]) bolt(hole);
    %translate([9.5,-wheel_length/2,-5]) rotate([90,0,0]) rotate([0,90,0]) bolt(hole);
    %translate([-9.5,-wheel_length/2,-5]) rotate([90,0,0]) rotate([0,-90,0]) bolt(hole);
    %translate([12,wheel_length/2,-5]) rotate([0,-90,0]) wheels();
    %translate([12,-wheel_length/2,-5]) rotate([0,-90,0]) wheels();
    %translate([-12,wheel_length/2,-5]) rotate([0,90,0]) wheels();
    %translate([-12,-wheel_length/2,-5]) rotate([0,90,0]) wheels();
    
    
    translate([(19+well_depth)/2,wheel_length/2,-5]) rotate([0,90,0]) cylinder(well_depth+1,wheel_well/2,(wheel_well+2)/2,center=true);
    translate([(19+well_depth)/2,-wheel_length/2,-5]) rotate([0,90,0]) cylinder(well_depth+1,wheel_well/2,(wheel_well+2)/2,center=true);
    translate([-(19+well_depth)/2,wheel_length/2,-5]) rotate([0,90,0]) cylinder(well_depth+1,(wheel_well+2)/2,wheel_well/2,center=true);
    translate([-(19+well_depth)/2,-wheel_length/2,-5]) rotate([0,90,0]) cylinder(well_depth+1,(wheel_well+2)/2,wheel_well/2,center=true);
   
  }
  hook_height = -0.5;
  translate([0,-(length/2+10),hook_height]) hook_2();
  translate([0,(length/2+9.5),hook_height]) 
  union()
  {
    hook_1();
    //hook support
    if (hook_support==1) translate([0,0,-6.25]) difference()
    {
      cylinder(7,14/2,14/2,center=true);
      cylinder(7+1,13/2,13/2,center=true);
    }
  }
}

module train_car_long(hook_support = 1, length = 63.75 +32, wheel_length = 60, width = 31.75, height = 20, hole = 6.0)
{
  wheel_well = 26;
  well_depth = (width - 19)/2;
  difference()
  {
    union()
    {
      cube([width,length,height],center=true);
      translate([0,0,(height-2)/2]) duplo_top(y=6);
    }
    
    //translate([0,wheel_length/2,-5]) rotate([0,90,0]) cylinder(width,hole/2,hole/2,center=true);
    //translate([0,-wheel_length/2,-5]) rotate([0,90,0]) cylinder(width,hole/2,hole/2,center=true);
    translate([9.5,wheel_length/2,-5]) rotate([90,0,0]) rotate([0,90,0]) bolt(hole);
    translate([-9.5,wheel_length/2,-5]) rotate([90,0,0]) rotate([0,-90,0]) bolt(hole);
    translate([9.5,-wheel_length/2,-5]) rotate([90,0,0]) rotate([0,90,0]) bolt(hole);
    translate([-9.5,-wheel_length/2,-5]) rotate([90,0,0]) rotate([0,-90,0]) bolt(hole);
    
    %translate([9.5,wheel_length/2,-5]) rotate([90,0,0]) rotate([0,90,0]) bolt(hole);
    %translate([-9.5,wheel_length/2,-5]) rotate([90,0,0]) rotate([0,-90,0]) bolt(hole);
    %translate([9.5,-wheel_length/2,-5]) rotate([90,0,0]) rotate([0,90,0]) bolt(hole);
    %translate([-9.5,-wheel_length/2,-5]) rotate([90,0,0]) rotate([0,-90,0]) bolt(hole);
    %translate([12,wheel_length/2,-5]) rotate([0,-90,0]) wheels();
    %translate([12,-wheel_length/2,-5]) rotate([0,-90,0]) wheels();
    %translate([-12,wheel_length/2,-5]) rotate([0,90,0]) wheels();
    %translate([-12,-wheel_length/2,-5]) rotate([0,90,0]) wheels();
    
    
    translate([(19+well_depth)/2,wheel_length/2,-5]) rotate([0,90,0]) cylinder(well_depth+1,wheel_well/2,(wheel_well+2)/2,center=true);
    translate([(19+well_depth)/2,-wheel_length/2,-5]) rotate([0,90,0]) cylinder(well_depth+1,wheel_well/2,(wheel_well+2)/2,center=true);
    translate([-(19+well_depth)/2,wheel_length/2,-5]) rotate([0,90,0]) cylinder(well_depth+1,(wheel_well+2)/2,wheel_well/2,center=true);
    translate([-(19+well_depth)/2,-wheel_length/2,-5]) rotate([0,90,0]) cylinder(well_depth+1,(wheel_well+2)/2,wheel_well/2,center=true);
   
  }
  hook_height = -0.5;
  translate([0,-(length/2+10),hook_height]) hook_2();
  translate([0,(length/2+9.5),hook_height]) 
  union()
  {
    hook_1();
    //hook support
    if (hook_support==1) translate([0,0,-6.25]) difference()
    {
      cylinder(7,14/2,14/2,center=true);
      cylinder(7+1,13/2,13/2,center=true);
    }
  }
}

module wheel2(wheel_thinkness = 3.0, 
wheel_diameter = 24.0,
axel_diameter = 5.0,
axel_mount_depth = 4.0)
{
  axel_support_thinkness = 3.5;
  center_slant = wheel_diameter;
  center_diameter = axel_mount_depth + axel_support_thinkness;
  difference()
  {
    union()
    {
      difference()
      {
        cylinder(wheel_thinkness,wheel_diameter/2,wheel_diameter/2,center=true);
        cylinder(wheel_thinkness+0.1,(wheel_diameter-3)/2,0,center=true);
      }
      translate([0,0,-(axel_mount_depth-wheel_thinkness)/2]) cylinder(axel_mount_depth,center_diameter/2,center_slant/2,center=true);
    }
    translate([0,0,-(axel_mount_depth-wheel_thinkness)/2]) cylinder(axel_mount_depth+1,axel_diameter/2,axel_diameter/2,center=true);
  }
}

module simple_axel(length, thickness)
{
  cylinder(length,thickness/2,thickness/2,center=true);
}

module wheel_assembly(wheel_base = 25.35,
wheel_thinkness = 3.0, 
wheel_diameter = 22.0,
axel_diameter = 5.0,
axel_mount_depth = 4.0)
{
  %translate([wheel_base/2,0,0]) rotate([0,-90,0]) wheel2(wheel_thinkness, wheel_diameter, axel_diameter, axel_mount_depth);
  %translate([-wheel_base/2,0,0]) rotate([0,90,0]) wheel2(wheel_thinkness, wheel_diameter, axel_diameter, axel_mount_depth);
  rotate([0,90,0]) simple_axel(wheel_base+2*(axel_mount_depth-wheel_thinkness/2), axel_diameter);
}

module short_block(spacing = 32)
{
  translate([0,spacing/2,0]) wheel_assembly();
  translate([0,-spacing/2,0]) wheel_assembly();
  //TODO make a spinning, loose duplo top for this train car part
  translate([0,0,8]) cylinder(10,8,8,center=true);
  
  translate([0,0,12]) cylinder(2,(spacing-4)/2,(spacing+4)/2,center=true);
  
  translate([0,0,14]) duplo_top(x = 2, y = 3);
  //TODO add one magnet mount block to match the other train cars
}

module tack()
{
  pin_diameter = 1.4;
  pin_length = 17;
  tack_diameter = 11;
  tack_thickness = 3.65;
  color("gray") union()
  {
    cylinder(pin_length,pin_diameter/2,pin_diameter/2,center=true);
    translate([0,0,(pin_length-tack_thickness)/2]) cylinder(tack_thickness,tack_diameter/2,pin_diameter/2,center=true);
  }
}

module magnet()
{
  od = 12.7;
  id = 3.175;
  thickness = 3.175;
  color("lightblue") difference()
  {
    cylinder(thickness,od/2,od/2,center=true);
    cylinder(thickness+0.1,id/2,id/2,center=true);
  }
}

module magnet_assembly()
{
  tack();
  translate([0,0,(17/2-(3.6+3.175/2))]) magnet();
}

module magnet_holder(magnet_od = 12.7,
pin_od = 1.4,
pin_depth = 10.225,
magnet_depth = 3.175,
thickness = 2)
{
  holder_od = magnet_od + 2 * thickness;
  difference()
  {
    cylinder(pin_depth+magnet_depth,holder_od/2,holder_od/2,center=true);
    translate([0,0,pin_depth/2]) cylinder(magnet_depth+0.1,magnet_od/2,magnet_od/2,center=true);
    cylinder(pin_depth+magnet_depth,pin_od/2,pin_od/2,center=true);
  }
}

module short_car()
{
  spacing = 40;
  magnet_height = 16.5;
  wheel_base = 25.35;
  wheel_thinkness = 3.0;
  wheel_diameter = 22.0;
  axel_diameter = 5.0;
  axel_clearance = 0.25 + axel_diameter;
  wheel_well = wheel_diameter + 2;
  //wheel assembly place holder
  %translate([0,spacing/2,0]) wheel_assembly(wheel_base,wheel_thinkness,wheel_diameter,axel_diameter);
  %translate([0,-spacing/2,0]) wheel_assembly(wheel_base,wheel_thinkness,wheel_diameter,axel_diameter);
  
  //duplo train top
  translate([0,0,14]) duplo_top(x = 2, y = 4);
  
  //train body
  body_width = wheel_base-wheel_thinkness*2;
  well_depth = (32 - body_width)/2;
  difference()
  {
    union()
    {
      translate([0,0,wheel_diameter/4]) cube([body_width,64,14+axel_diameter],center=true);
      difference()
      {
        union()
        {
          translate([(32-10)/2,0,12]) cube([10,64,5],center=true);
          translate([-(32-10)/2,0,12]) cube([10,64,5],center=true);
        }
        translate([(32-10)/2,0,12]) rotate([0,-30,0]) translate([0,0,-4]) cube([10,65,5],center=true);
        translate([-(32-10)/2,0,12]) rotate([0,30,0]) translate([0,0,-4]) cube([10,65,5],center=true);
      }
    }
    translate([0,spacing/2,0]) rotate([0,90,0]) cylinder(body_width+0.1,axel_clearance/2,axel_clearance/2,center=true);
    translate([0,-spacing/2,0]) rotate([0,90,0]) cylinder(body_width+0.1,axel_clearance/2,axel_clearance/2,center=true);
    translate([0,0,-wheel_diameter/3]) rotate([0,90,0]) cylinder(body_width+0.1,wheel_diameter/2,wheel_diameter/2,center=true);
    //removing wheel well area
    translate([0,spacing/2,0]) translate([wheel_base/2,0,0]) rotate([0,-90,0])  cylinder(well_depth,wheel_well/2,wheel_well/2,center=true);
    translate([0,-spacing/2,0]) translate([wheel_base/2,0,0]) rotate([0,-90,0])  cylinder(well_depth,wheel_well/2,wheel_well/2,center=true);
    translate([0,spacing/2,0]) translate([-wheel_base/2,0,0]) rotate([0,-90,0])  cylinder(well_depth,wheel_well/2,wheel_well/2,center=true);
    translate([0,-spacing/2,0]) translate([-wheel_base/2,0,0]) rotate([0,-90,0])  cylinder(well_depth,wheel_well/2,wheel_well/2,center=true);
    
  }
  
  //magnet holders
  translate([0,-32,magnet_height-wheel_diameter/2]) rotate([90,0,0]) magnet_holder();
  translate([0,32,magnet_height-wheel_diameter/2]) rotate([-90,0,0]) magnet_holder();
}

module train_car1(hook_support = 1, 
length = 63.75, 
wheel_length = 40, 
width = 31.75, 
height = 20, 
hole = 6.0)
{
  wheel_well = 26;
  well_depth = (width - 19)/2;
  difference()
  {
    union()
    {
      cube([width,length,height],center=true);
      //translate([0,0,(height-2)/2]) duplo_top();
    }
    
    //translate([0,wheel_length/2,-5]) rotate([0,90,0]) cylinder(width,hole/2,hole/2,center=true);
    //translate([0,-wheel_length/2,-5]) rotate([0,90,0]) cylinder(width,hole/2,hole/2,center=true);
    translate([9.5,wheel_length/2,-5]) rotate([90,0,0]) rotate([0,90,0]) bolt(hole);
    translate([-9.5,wheel_length/2,-5]) rotate([90,0,0]) rotate([0,-90,0]) bolt(hole);
    translate([9.5,-wheel_length/2,-5]) rotate([90,0,0]) rotate([0,90,0]) bolt(hole);
    translate([-9.5,-wheel_length/2,-5]) rotate([90,0,0]) rotate([0,-90,0]) bolt(hole);
    
    %translate([9.5,wheel_length/2,-5]) rotate([90,0,0]) rotate([0,90,0]) bolt(hole);
    %translate([-9.5,wheel_length/2,-5]) rotate([90,0,0]) rotate([0,-90,0]) bolt(hole);
    %translate([9.5,-wheel_length/2,-5]) rotate([90,0,0]) rotate([0,90,0]) bolt(hole);
    %translate([-9.5,-wheel_length/2,-5]) rotate([90,0,0]) rotate([0,-90,0]) bolt(hole);
    %translate([12,wheel_length/2,-5]) rotate([0,-90,0]) wheels();
    %translate([12,-wheel_length/2,-5]) rotate([0,-90,0]) wheels();
    %translate([-12,wheel_length/2,-5]) rotate([0,90,0]) wheels();
    %translate([-12,-wheel_length/2,-5]) rotate([0,90,0]) wheels();
    
    
    translate([(19+well_depth)/2,wheel_length/2,-5]) rotate([0,90,0]) cylinder(well_depth+1,wheel_well/2,(wheel_well+2)/2,center=true);
    translate([(19+well_depth)/2,-wheel_length/2,-5]) rotate([0,90,0]) cylinder(well_depth+1,wheel_well/2,(wheel_well+2)/2,center=true);
    translate([-(19+well_depth)/2,wheel_length/2,-5]) rotate([0,90,0]) cylinder(well_depth+1,(wheel_well+2)/2,wheel_well/2,center=true);
    translate([-(19+well_depth)/2,-wheel_length/2,-5]) rotate([0,90,0]) cylinder(well_depth+1,(wheel_well+2)/2,wheel_well/2,center=true);
   
  }
  hook_height = -0.5;
  translate([0,-(length/2+10),hook_height]) hook_2();
  translate([0,(length/2+9.5),hook_height]) 
  union()
  {
    hook_1();
    //hook support
    if (hook_support==1) translate([0,0,-6.25]) difference()
    {
      cylinder(7,14/2,14/2,center=true);
      cylinder(7+1,13/2,13/2,center=true);
    }
  }
}


//wheels();
//rotate([90,0,0]) bolt();
//train_car_long(hook_support = 1);
//train_car1(hook_support = 0);
//short_block();

//short_car();
//rotate([180,0,0]) wheel2();
wheel_assembly();
