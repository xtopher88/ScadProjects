


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


module duplo_support(width, height, y = 4, spacing = 16.0, parimeter = 3.2+9.35/2, height = 4.5, thickness = 2)
{
  cube([width,(y-1)*spacing+2*parimeter,height],center=true);
}


module wheel2(wheel_thinkness = 4.0, 
wheel_diameter = 22.0,
axel_diameter = 5.0,
axel_mount_depth = 6.0)
{
  axel_support_thinkness = 1;
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
wheel_thinkness = 4.0, 
wheel_diameter = 22.0,
axel_diameter = 3.175,
axel_mount_depth = 6.0)
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

module magnet_holder(magnet_od = 12.7+0.7,
pin_od = 1.4,
pin_depth = 10.225,
magnet_depth = 3.175,
thickness = 1)
{
  holder_od = magnet_od + 2 * thickness;
  difference()
  {
    union()
    {
      cylinder(pin_depth+magnet_depth,holder_od/2,holder_od/2,center=true);
      translate([0,thickness-holder_od/2],0) cube([holder_od/2,2 * thickness,pin_depth+magnet_depth],center=true);
    }
    translate([0,0,pin_depth/2]) cylinder(magnet_depth+0.1,magnet_od/2,magnet_od/2,center=true);
    cylinder(pin_depth+magnet_depth,pin_od/2,pin_od/2,center=true);
  }
}

module magnet_holder1()
{
  magnet_holder(9.525+0.6,1.4,10.225,1.6);
}

module short_car(mode = 0)
{
  //mode 0 is the body with wheel assembly grayed out
  //mode 1 shows the wheels only on there side
  //mode 2 shows the axel only
  
  spacing = 40;
  
  wheel_base = 25.35;
  wheel_thinkness = 4.0;
  wheel_diameter = 22.0;
  axel_diameter = 3.175+0.4;  //0.125 inch rod
  axel_clearance = 0.4 + axel_diameter;
  wheel_well = wheel_diameter + 3;
  axel_mount_depth = 6.0;
  
  magnet_height = 16.5-2.6;
  
  
  if(mode == 0)
  {
    //wheel assembly place holder
    %translate([0,spacing/2,0]) wheel_assembly(wheel_base,wheel_thinkness,wheel_diameter,axel_diameter,axel_mount_depth);
    %translate([0,-spacing/2,0]) wheel_assembly(wheel_base,wheel_thinkness,wheel_diameter,axel_diameter,axel_mount_depth);
    
    //duplo train top
    translate([0,0,14]) duplo_top(x = 2, y = 4);
    
    //train body
    body_width = wheel_base-wheel_thinkness*2;
    well_depth = (32 - body_width)/2;
    difference()
    {
      union()
      {
        //magnet holders
        translate([0,-32,magnet_height-wheel_diameter/2-0.125]) rotate([90,0,0]) magnet_holder1();
        translate([0,32,magnet_height-wheel_diameter/2-0.125]) rotate([-90,180,0]) magnet_holder1();
        //main body
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
      
      //ensure the pins have a full hole
      pin_od = 1.4;
      translate([0,-32,magnet_height-wheel_diameter/2]) rotate([90,0,0]) cylinder(17,pin_od/2,pin_od/2,center=true);
      translate([0,32,magnet_height-wheel_diameter/2]) rotate([-90,0,0]) cylinder(17,pin_od/2,pin_od/2,center=true);
    }
  }
  else
  {
    if(mode == 1)
    {
      rotate([180,0,0]) wheel2(wheel_thinkness, wheel_diameter, axel_diameter, axel_mount_depth);
    }
    else
    {
      rotate([90,0,0]) simple_axel(wheel_base+2*(axel_mount_depth-wheel_thinkness/2), axel_diameter);
    }
  }
  
}

module train_truck(mode = 0)
{
  wheel_base = 25.35;
  wheel_thinkness = 4.0;
  wheel_diameter = 22.0;
  axel_diameter = 3.175+0.4;  //0.125 inch rod
  axel_clearance = 0.4 + axel_diameter;
  wheel_well = wheel_diameter + 3;
  axel_mount_depth = 6.0;
  
  magnet_height = 16.5-2.6;
  spacing = wheel_diameter + 2;
  
  length = wheel_diameter + spacing + 5;
  height = 10;
  
  if(mode == 0)
  {
    //wheel assembly place holder
    %translate([0,spacing/2,0]) wheel_assembly(wheel_base,wheel_thinkness,wheel_diameter,axel_diameter,axel_mount_depth);
    %translate([0,-spacing/2,0]) wheel_assembly(wheel_base,wheel_thinkness,wheel_diameter,axel_diameter,axel_mount_depth);
    
    //train body
    body_width = wheel_base-wheel_thinkness*2;
    difference()
    {
      union()
      {
        //magnet holders
        translate([0,-length/2+2,magnet_height-wheel_diameter/2]) rotate([90,0,0]) magnet_holder1();
        //main body
        translate([0,0,height/2-2]) minkowski()
        {
          rounding = 2;
          cube([body_width-rounding,length-rounding,height+axel_diameter-rounding],center=true);
          sphere(rounding/2);
        }
      }
      translate([0,spacing/2,0]) rotate([0,90,0]) cylinder(body_width+0.1,axel_clearance/2,axel_clearance/2,center=true);
      translate([0,-spacing/2,0]) rotate([0,90,0]) cylinder(body_width+0.1,axel_clearance/2,axel_clearance/2,center=true);
      
      //ensure the pins have a full hole
      pin_od = 1.4;
      %translate([0,-length/2+4,magnet_height-wheel_diameter/2]) rotate([90,0,0]) cylinder(17,pin_od/2,pin_od/2,center=true);
      
      through_hole = 4;
      mount_diameter = 7;
      mount_thickness = 4;
      //rotational hole and mounting
      translate([0,0,height/2-2]) cylinder(height+axel_diameter+1,through_hole,through_hole,center=true);
      translate([0,0,mount_thickness/2-4]) cylinder(mount_thickness,mount_diameter,mount_diameter,center=true);
      translate([0,0,height+mount_thickness/2-4]) cylinder(mount_thickness,mount_diameter,mount_diameter,center=true);
      
    }
  }
  else
  {
    if(mode == 1)
    {
      rotate([180,0,0]) wheel2(wheel_thinkness, wheel_diameter, axel_diameter, axel_mount_depth);
    }
    else
    {
      echo(wheel_base+2*(axel_mount_depth-wheel_thinkness/2));
      rotate([90,0,0]) simple_axel(wheel_base+2*(axel_mount_depth-wheel_thinkness/2), axel_diameter);
    }
  }
  
}

module truck_plug(length = 15)
{
  mount_diameter = 6;
  mount_thickness = 2;
  through_hole = 3;

  translate([0,0,length/2]) cylinder(length,through_hole,through_hole,center=true);
  translate([0,0,mount_thickness/2]) cylinder(mount_thickness,mount_diameter,mount_diameter,center=true);
}

module truck_car()
{
  spacing = 60;
  mount_diameter = 6;
  mount_thickness = 8;
  through_hole = 3;
  difference()
  {
    union()
    {
      //duplo train top
      translate([0,0,14]) duplo_top(x = 2, y = 6);
      translate([0,0,14-2]) duplo_support(10, 2, y = 6);
      translate([0,-spacing/2,14-mount_thickness/2]) cylinder(mount_thickness,mount_diameter,mount_diameter,center=true); 
      translate([0,spacing/2,14-mount_thickness/2]) cylinder(mount_thickness,mount_diameter,mount_diameter,center=true);  
    }
    translate([0,-spacing/2,14-mount_thickness/2]) cylinder(mount_thickness,through_hole,through_hole,center=true);  
    translate([0,spacing/2,14-mount_thickness/2]) cylinder(mount_thickness,through_hole,through_hole,center=true);  
  }
  
  %translate([0,-spacing/2,-3]) truck_plug();
  %translate([0,spacing/2,-3]) truck_plug();
  
  %translate([0,-spacing/2,0]) train_truck();
  %translate([0,spacing/2,0]) rotate([0,0,180]) train_truck();
}

//wheels();
//rotate([90,0,0]) bolt();
//train_car_long(hook_support = 1);
//train_car1(hook_support = 0);
//short_block();

short_car(0);

//train_truck(2);
//truck_car();
//truck_plug();
//rotate([180,0,0]) wheel2();
//wheel_assembly();
