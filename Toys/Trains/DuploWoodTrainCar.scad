
sf = 1.0;

module duplo_nipple(outer = 9.35, inner = 6.93, height = 4.5)
{
  difference()
  {
    cylinder(height*sf,outer*sf/2,outer*sf/2,center=true);
    cylinder(height*sf+1,inner*sf/2,inner*sf/2,center=true);
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
        translate([sf*((i-(x-1)/2)*spacing),sf*((j-(y-1)/2)*spacing),(height+thickness)/2]) duplo_nipple();
      }
    }
    cube([sf*(x-1)*spacing+2*parimeter,sf*(y-1)*spacing+2*parimeter,sf*thickness],center=true);
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
        cylinder(thickness*sf,outer_diameter*sf/2,outer_diameter*sf/2,center=true);
        translate([sf*(outer_diameter)/4,0,0]) cube([sf*outer_diameter/2,sf*outer_diameter,sf*thickness+1],center=true);
      }
      translate([0,sf*(inner_diameter/2+wall_thinkness/2),0]) cylinder(thickness*sf,sf*wall_thinkness/2,sf*wall_thinkness/2,center=true);
    }
    cylinder(thickness*sf+1,inner_diameter*sf/2,inner_diameter*sf/2,center=true);
    translate([0,0,-(thickness*3+0.1)*sf/8]) cylinder(thickness*sf/4,(inner_diameter+3)*sf/2,inner_diameter*sf/2,center=true);
    translate([0,0,(thickness*3+0.1)*sf/8]) cylinder(thickness*sf/4,inner_diameter*sf/2,(inner_diameter+3)*sf/2,center=true);
  
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
    translate([0,-sf*7.5,0])  cube([sf*attach_length,sf*attach_width,sf*attach_thickness],center=true);
  }
  //%cube([sf*6.35,sf*20,sf*6],center=true);
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
  translate([0,0,-sf*1.5]) 
  union()
  {
    cylinder(sf*height,sf*hook_diameter/2,sf*hook_diameter/2,center=true);
    translate([0,0,sf*(height-latch_thickness)/2]) 
    difference()
    {
      cylinder(sf*latch_thickness,sf*latch_diameter/2,sf*latch_diameter/2,center=true);
      translate([0,sf*latch_diameter/4,0]) cube([sf*latch_diameter,sf*latch_diameter/2,sf*latch_thickness+1],center=true);
    }
    translate([0,sf*4.5,-sf*(height-attach_thickness)/2])  
    difference()
    {
      cube([sf*attach_length,sf*attach_width,sf*attach_thickness],center=true);
      translate([-8.5,0,0]) rotate([0,0,18]) cube([sf*attach_length/2,sf*attach_width*2,sf*attach_thickness+1],center=true);
      translate([8.5,0,0]) rotate([0,0,-18]) cube([sf*attach_length/2,sf*attach_width*2,sf*attach_thickness+1],center=true);
    
    }
  }
}

module train_car(length = 63.75, wheel_length = 40, width = 31.75, height = 20, hole = 6.0)
{
  wheel_well = 26;
  well_depth = (width - 19)/2;
  difference()
  {
    union()
    {
      cube([sf*width,sf*length,sf*height],center=true);
      translate([0,0,sf*(height-2)/2]) duplo_top();
    }
    
    translate([0,sf*wheel_length/2,-sf*5]) rotate([0,90,0]) cylinder(width*sf,hole*sf/2,hole*sf/2,center=true);
    translate([0,-sf*wheel_length/2,-sf*5]) rotate([0,90,0]) cylinder(width*sf,hole*sf/2,hole*sf/2,center=true);
    
    translate([sf*(19+well_depth)/2,sf*wheel_length/2,-sf*5]) rotate([0,90,0]) cylinder(well_depth*sf+1,wheel_well*sf/2,(wheel_well+2)*sf/2,center=true);
    translate([sf*(19+well_depth)/2,-sf*wheel_length/2,-sf*5]) rotate([0,90,0]) cylinder(well_depth*sf+1,wheel_well*sf/2,(wheel_well+2)*sf/2,center=true);
    translate([-sf*(19+well_depth)/2,sf*wheel_length/2,-sf*5]) rotate([0,90,0]) cylinder(well_depth*sf+1,(wheel_well+2)*sf/2,wheel_well*sf/2,center=true);
    translate([-sf*(19+well_depth)/2,-sf*wheel_length/2,-sf*5]) rotate([0,90,0]) cylinder(well_depth*sf+1,(wheel_well+2)*sf/2,wheel_well*sf/2,center=true);
   
  }
  hook_height = -0.5;
  translate([0,sf*(length/2+9.5),sf*hook_height]) hook_1();
  translate([0,-sf*(length/2+10),sf*hook_height]) hook_2();
}

train_car();

