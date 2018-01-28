use <publicDomainGearV1.1.scad>;

rod_od = 5.8;
clearance = 0.2;
in_to_mm = 25.4;

module carbon_rod(length = 120)
{
  od = rod_od;
  id = 3.5;
  color("DarkSlateGray") difference()
  {
    cylinder(length,od/2,od/2,center=true);
    cylinder(length+1,id/2,id/2,center=true);
  }
}

module NEMA17(length = 25, mode = 0)
{
  width = 42;
  shaft_length = 20;
  shaft_diameter = 5;
  center_legth = 2;
  center_diameter = 22;
  screw_diameter = 4;
  screw_depth = 4.5;
  screw_location = 15.5;
  if( mode == 0 )
  {
    color("WhiteSmoke") union()
    {
      difference()
      {
        translate([0,0,-length/2]) cube([width,width,length],center=true);
        translate([screw_location,screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
        translate([-screw_location,screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
        translate([screw_location,-screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
        translate([-screw_location,-screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
      }
      translate([0,0,center_legth/2]) cylinder(center_legth,center_diameter/2,center_diameter/2,center=true);
      translate([0,0,shaft_length/2]) cylinder(shaft_length,shaft_diameter/2,shaft_diameter/2,center=true);
    }
  }
}


module NEMA11(length = 31.5, mode = 0)
{
  width = 28;
  shaft_length = 20;
  shaft_diameter = 5;
  center_legth = 2;
  center_diameter = 22;
  screw_diameter = 2.5;
  screw_depth = 4;
  screw_location = 23/2;
  if( mode == 0 )
  {
    color("WhiteSmoke") union()
    {
      difference()
      {
        translate([0,0,-length/2]) cube([width,width,length],center=true);
        translate([screw_location,screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
        translate([-screw_location,screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
        translate([screw_location,-screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
        translate([-screw_location,-screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
      }
      translate([0,0,center_legth/2]) cylinder(center_legth,center_diameter/2,center_diameter/2,center=true);
      translate([0,0,shaft_length/2]) cylinder(shaft_length,shaft_diameter/2,shaft_diameter/2,center=true);
    }
  }
}

module NEMA8(length = 28, mode = 0)
{
  width = 20;
  shaft_length = 10;
  shaft_diameter = 3.5;
  center_legth = 1.5;
  center_diameter = 16;
  screw_diameter = 2;
  screw_depth = 2.5;
  screw_location = 15.4/2;
  if( mode == 0 )
  {
    color("WhiteSmoke") union()
    {
      difference()
      {
        translate([0,0,-length/2]) cube([width,width,length],center=true);
        translate([screw_location,screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
        translate([-screw_location,screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
        translate([screw_location,-screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
        translate([-screw_location,-screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
      }
      translate([0,0,center_legth/2]) cylinder(center_legth,center_diameter/2,center_diameter/2,center=true);
      translate([0,0,shaft_length/2]) cylinder(shaft_length,shaft_diameter/2,shaft_diameter/2,center=true);
    }
  }
  else
  {
    remove_length = 10;
    translate([0,0,remove_length/2]) cylinder(remove_length+0.1,center_diameter/2,center_diameter/2,center=true);
    translate([screw_location,screw_location,remove_length/2]) cylinder(remove_length+0.1,screw_diameter/2,screw_diameter/2,center=true);
    translate([-screw_location,screw_location,remove_length/2]) cylinder(remove_length+0.1,screw_diameter/2,screw_diameter/2,center=true);
    translate([screw_location,-screw_location,remove_length/2]) cylinder(remove_length+0.1,screw_diameter/2,screw_diameter/2,center=true);
    translate([-screw_location,-screw_location,remove_length/2]) cylinder(remove_length+0.1,screw_diameter/2,screw_diameter/2,center=true);
  }
}

module HollowStepper1(mode = 0)
{
  width = 39;
  length = 22;
  shaft_length = 13;
  shaft_diameter = 8;
  shaft_id = 6.1;
  center_legth = 2;
  center_diameter = 22;
  screw_diameter = 2;
  screw_depth = 2.5;
  screw_location = 31/2;
  if( mode == 0 )
  {
    color("WhiteSmoke") difference()
    {
      union()
      {
        translate([0,0,-length/2]) cube([width,width,length],center=true);
        translate([0,0,center_legth/2]) cylinder(center_legth,center_diameter/2,center_diameter/2,center=true);
        translate([0,0,shaft_length/2]) cylinder(shaft_length,shaft_diameter/2,shaft_diameter/2,center=true);
      }
      
      translate([0,0,-(center_diameter-shaft_length)/2]) cylinder(shaft_length+length+1,shaft_id/2,shaft_id/2,center=true);
      translate([screw_location,screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
      translate([-screw_location,screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
      translate([screw_location,-screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
      translate([-screw_location,-screw_location,-screw_depth/2]) cylinder(screw_depth+0.1,screw_diameter/2,screw_diameter/2,center=true);
    }
  }
  else
  {
    remove_length = 10;
    translate([0,0,remove_length/2]) cylinder(remove_length+0.1,center_diameter/2,center_diameter/2,center=true);
    translate([screw_location,screw_location,remove_length/2]) cylinder(remove_length+0.1,screw_diameter/2,screw_diameter/2,center=true);
    translate([-screw_location,screw_location,remove_length/2]) cylinder(remove_length+0.1,screw_diameter/2,screw_diameter/2,center=true);
    translate([screw_location,-screw_location,remove_length/2]) cylinder(remove_length+0.1,screw_diameter/2,screw_diameter/2,center=true);
    translate([-screw_location,-screw_location,remove_length/2]) cylinder(remove_length+0.1,screw_diameter/2,screw_diameter/2,center=true);
    
    
  }
}

module bearing(mode = 0, id = 8, od = 22, width = 7)
{
  if( mode == 0 )
  {
    union()
    {
      color("LightSlateGray") difference()
      {
        cylinder(width,od/2,od/2,center=true);
        cylinder(width+0.1,(od-(od-id)/4)/2,(od-(od-id)/4)/2,center=true);
      }
      color("LightSlateGray") difference()
      {
        cylinder(width,(id+(od-id)/4)/2,(id+(od-id)/4)/2,center=true);
        cylinder(width+0.1,id/2,id/2,center=true);
      }
      color("Maroon") difference()
      {
        cylinder(width*5/6,(od-(od-id)/4)/2,(od-(od-id)/4)/2,center=true);
        cylinder(width,id/2+0.1,id/2+0.1,center=true);
      }
    }
  }
  else
  {
    if( mode == 1 )
    {
        cylinder(width+0.4,od/2+0.1,od/2+0.1,center=true);
    }
    else
    {
      difference()
      {
        cylinder(width,od/2,od/2,center=true);
        cylinder(width+0.1,id/2,id/2,center=true);
      }
    }
  }
}

module limit_switch(mode = 0)
{
  height = 12.58;
  width = 7.8;
  screw_diameter = 2.5;
  
  if(mode == 0)
  {
    color("Navy") difference()
    {
      union()
      {
        translate([2.5+4.3/2,0,height/2]) cube([4.3,4.7,height],center=true);
        translate([-(2.5+4.3/2),0,height/2]) cube([4.3,4.7,height],center=true);
        translate([2.5+4.3/2,0,2/2]) cube([23,width,2],center=true);
        translate([0,0,5.6/2]) cube([13.6,width,5.6],center=true);
        translate([-(2.5+10/2+4.3),0,5.6/2+2]) cube([10,width,5.8],center=true);
        translate([2.5+9.6-18.1+2.4/2,(width-0.9)/2,-1.8/2]) cube([2.4,0.9,1.8],center=true);
        translate([2.5+9.6-18.1+2.4/2,-(width-0.9)/2,-1.8/2]) cube([2.4,0.9,1.8],center=true);
      }
      translate([2.5+9.6,0,2/2]) cylinder(3,3.2/2,3.2/2,center=true);
    }
  }
  else
  {
      translate([2.5+9.6-18.1+2.4/2,(width-0.9)/2,-1.8/2]) cube([2.4+0.5,0.9+0.3,1.8+0.3],center=true);
      translate([2.5+9.6-18.1+2.4/2,-(width-0.9)/2,-1.8/2]) cube([2.4+0.5,0.9+0.3,1.8+0.3],center=true);
      translate([2.5+9.6,0,-10/2]) cylinder(10+1,screw_diameter/2,screw_diameter/2,center=true);
  }
}

module linear_slide(shaft_side_pos=0,guide_depth=0,mode=0)
{
  mm_per_tooth    = 3;
  number_of_teeth = 37;
  length = mm_per_tooth * number_of_teeth;
  screw_location = 15.5;
  thickness = 10;
  screw_diameter = 5;
  screw_diameter = 10;
  side_length = shaft_side_pos*2+15;
  bearing_side_pos = 12;
  motor_side_pos = -12;
  rod_holes = rod_od + clearance;
  
  number_of_gear_teeth = 13;
  
  gear_spacing = pitch_radius(mm_per_tooth,number_of_gear_teeth)+0.5;
  echo(gear_spacing);
  module slide_bottom()
  {
    difference()
    {
      union()
      {
        cube([side_length,thickness,10],center=true);
        translate([0,30/2,-2.5]) cube([side_length,30,5],center=true);
        
        //home switch flag
        translate([(side_length+8)/2,-(thickness-2)/2,0]) cube([8,2,10],center=true);
        translate([(side_length+9)/2,-(thickness-2)/2,5]) cube([7,2,10],center=true);
      
        //bearing mount
        translate([bearing_side_pos,20,-1.5+25/2]) cylinder(25+7,25/2,25/2,center=true);
        translate([bearing_side_pos,10,-1.5+25/2]) cube([7,10,25+7],center=true);
      }
      translate([motor_side_pos,20,0]) rotate([180,0,0]) NEMA8(28, 1);
      translate([bearing_side_pos,20,-1.5]) rotate([180,0,0]) bearing(1);
      translate([bearing_side_pos,20,-1.5+25]) rotate([180,0,0]) bearing(1);
      translate([bearing_side_pos,20,-1.5+25/2]) cylinder(25+8,18/2,18/2,center=true);
      
      translate([shaft_side_pos,0,0]) cylinder(thickness+1,rod_holes/2,rod_holes/2,center=true);
      translate([-shaft_side_pos,0,0]) cylinder(thickness+1,rod_holes/2,rod_holes/2,center=true);
    }
    %translate([motor_side_pos,20,0]) rotate([180,0,0]) NEMA8();
    %translate([bearing_side_pos,20,-1.5]) bearing();
    %translate([bearing_side_pos,20,-1.5+25]) bearing();
  }
  
  if(mode != 1)
  {
    union()
    {
      //6.5
      translate([gear_spacing,shaft_depth_pos,length/2]) rotate([0,90,90]) rack (
        mm_per_tooth,    //this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
        number_of_teeth,   //total number of teeth along the rack
        thickness,    //thickness of rack in mm (affects each tooth)
        height          = 10   //height of rack in mm, from tooth top to far side of rack.
      );
      translate([0,guide_depth,-length/2]) slide_bottom();
      
      
      translate([0,guide_depth,length/2]) difference()
      {
        cube([side_length,thickness,10],center=true);
        translate([shaft_side_pos,0,0]) cylinder(thickness+1,rod_holes/2,rod_holes/2,center=true);
        translate([-shaft_side_pos,0,0]) cylinder(thickness+1,rod_holes/2,rod_holes/2,center=true);
      }
   }
  }
  
  if(mode != 2)
  {
    rotate([0,14,0]) translate([0,shaft_depth_pos,0]) rotate([0,90,90]) gear (
      mm_per_tooth,    //this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
      number_of_gear_teeth,   //total number of teeth around the entire perimeter
      thickness       = 15,    //thickness of gear in mm
      hole_diameter   = 5+0.2    //diameter of the hole in the center, in mm
      );
  }
}

module tube_n_guage(od, id, length)
{
  color("PaleVioletRed")  difference()
  {
    cylinder(length,od/2,od/2,center=true);
    cylinder(length+1,id/2,id/2,center=true);
  }
}

module tube_12_guage(length = 50)
{
  od= 0.1090 * in_to_mm;
  id = 0.0950 * in_to_mm;
  tube_n_guage(od, id, length);
}

module tube_18_guage(length = 50)
{
  od= 0.05 * in_to_mm;
  id = 0.042 * in_to_mm;
  tube_n_guage(od, id, length);
}

module tube_23_guage(length = 50)
{
  od= 0.0253 * in_to_mm;
  id = 0.013 * in_to_mm;
  tube_n_guage(od, id, length);
}

module slide_coller(od = 6.15, id = 3.0)
{
  lip = 8;
  lip_thickness = 2;
  length = 10;
  color("Navy")  difference()
  {
    union()
    {
      translate([0,0,lip_thickness/2]) cylinder(lip_thickness,lip/2,lip/2,center=true);
      translate([0,0,-length/2]) cylinder(length,od/2,od/2,center=true);
    }
    translate([0,0,(lip_thickness-length)/2]) cylinder(length+lip_thickness+1,id/2,id/2,center=true);
  }
}

module slide_coller_bottom(od = 6.15, id = 3.0)
{
  lip = 8;
  lip_thickness = 2;
  length = 10;
  anti_swivel_distance = 6;
  color("Navy")  difference()
  {
    union()
    {
      translate([0,anti_swivel_distance,lip_thickness/2]) cylinder(lip_thickness,lip/2,lip/2,center=true);
      translate([0,-anti_swivel_distance,lip_thickness/2]) cylinder(lip_thickness,lip/2,lip/2,center=true);
      translate([0,0,lip_thickness/2]) cube([lip,anti_swivel_distance*2,lip_thickness],center=true);
      translate([0,0,-length/2]) cylinder(length,od/2,od/2,center=true);
    }
    translate([0,0,(lip_thickness-length)/2]) cylinder(length+lip_thickness+1,id/2,id/2,center=true);
    
    translate([0,anti_swivel_distance,(lip_thickness)/2]) cylinder(lip_thickness+1,id/2,id/2,center=true);
    translate([0,-anti_swivel_distance,(lip_thickness)/2]) cylinder(lip_thickness+1,id/2,id/2,center=true);
  
  }
}


module anti_swivel_fitting(od = 6.15, id = 2.6, thickness = 5)
{
  lip = thickness;
  lip_thickness = thickness;
  length = 10;
  anti_swivel_distance = 6;
  color("Navy")  difference()
  {
    union()
    {
      translate([0,anti_swivel_distance,lip_thickness/2]) cylinder(lip_thickness,lip/2,lip/2,center=true);
      translate([0,-anti_swivel_distance,lip_thickness/2]) cylinder(lip_thickness,lip/2,lip/2,center=true);
      translate([0,0,lip_thickness/2]) cube([lip,anti_swivel_distance*2,lip_thickness],center=true);
    }
    translate([0,0,(lip_thickness-length)/2]) cylinder(length+lip_thickness+1,id/2,id/2,center=true);
    
    translate([0,anti_swivel_distance,(lip_thickness)/2]) cylinder(lip_thickness+1,id/2,id/2,center=true);
    translate([0,-anti_swivel_distance,(lip_thickness)/2]) cylinder(lip_thickness+1,id/2,id/2,center=true);
  }
}

module linear_slide1(shaft_side_pos=0,guide_depth=0,mode=0)
{
  mm_per_tooth    = 3;
  number_of_teeth = 37;
  length = mm_per_tooth * number_of_teeth;
  screw_location = 15.5;
  thickness = 10;
  screw_diameter = 5;
  screw_diameter = 10;
  side_length = shaft_side_pos*2+15;
  rod_holes = rod_od + clearance;
  
  number_of_gear_teeth = 13;
  
  gear_spacing = pitch_radius(mm_per_tooth,number_of_gear_teeth)+0.5;
  echo(gear_spacing);
  module slide_bottom()
  {
    difference()
    {
      union()
      {
        cube([side_length,thickness,10],center=true);
        translate([0,50/2,-2.5]) cube([side_length,50,5],center=true);
        
        //home switch flag
        translate([(side_length+8)/2,-(thickness-2)/2,0]) cube([8,2,10],center=true);
        translate([(side_length+9)/2,-(thickness-2)/2,5]) cube([7,2,10],center=true);
      
      }
      translate([0,28,0]) rotate([180,0,0]) HollowStepper1(28, 1);
      
      translate([shaft_side_pos,0,0]) cylinder(thickness+1,rod_holes/2,rod_holes/2,center=true);
      translate([-shaft_side_pos,0,0]) cylinder(thickness+1,rod_holes/2,rod_holes/2,center=true);
    }
    %translate([0,28,-22-thickness/2]) rotate([180,0,0]) HollowStepper1();
    %translate([0,28,-22-thickness/2]) tube_12_guage(70);
    %translate([0,28,-22-thickness/2-13]) rotate([180,0,0]) slide_coller_bottom();
    %translate([0,28,-thickness/2]) rotate([0,0,0]) slide_coller();
    translate([0,28,-50-thickness/2]) anti_swivel_fitting();
  }
  
  if(mode != 1)
  {
    union()
    {
      //6.5
      difference()
      {
        translate([gear_spacing,shaft_depth_pos,length/2]) rotate([0,90,90]) rack (
          mm_per_tooth,    //this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
          number_of_teeth,   //total number of teeth along the rack
          thickness,    //thickness of rack in mm (affects each tooth)
          height          = 10   //height of rack in mm, from tooth top to far side of rack.
        );
        translate([gear_spacing+thickness,shaft_depth_pos-thickness*3/4,0]) rotate([0,0,45]) cube([thickness,thickness,length],center=true);
      }
      translate([0,guide_depth,-length/2]) slide_bottom();
      
      
      translate([0,guide_depth,length/2]) difference()
      {
        cube([side_length,thickness,10],center=true);
        translate([shaft_side_pos,0,0]) cylinder(thickness+1,rod_holes/2,rod_holes/2,center=true);
        translate([-shaft_side_pos,0,0]) cylinder(thickness+1,rod_holes/2,rod_holes/2,center=true);
      }
   }
  }
  
  if(mode != 2)
  {
    rotate([0,14,0]) translate([0,shaft_depth_pos,0]) rotate([0,90,90]) gear (
      mm_per_tooth,    //this is the "circular pitch", the circumference of the pitch circle divided by the number of teeth
      number_of_gear_teeth,   //total number of teeth around the entire perimeter
      thickness       = 15,    //thickness of gear in mm
      hole_diameter   = 5+0.2    //diameter of the hole in the center, in mm
      );
  }
}

module slide_mount(shaft_side_pos, shaft_depth_pos, shaft_od = rod_od)
{
  center_diameter = 22+2;
  screw_diameter = 4+1;
  screw_location = 15.5;
  guide_diameter = 15;
  guide_thicknes = 10;
  
  mount_thickness = 5;
  height = 42;
  length = shaft_side_pos*2+guide_diameter;
  
  module shaft_guide(length,thickness,id)
  {
    difference()
    {
      union()
      {
        cylinder(length,thickness/2,thickness/2,center=true);
        translate([0,-shaft_depth_pos/2,0]) cube([thickness,shaft_depth_pos,length],center=true);
      }
      cylinder(length+1,id/2,id/2,center=true);
    }
  }
  module limit_holder()
  {
    difference()
    {
      union()
      {
        translate([-(10-4)/2,7.5-shaft_depth_pos/2,15/2]) cube([4,shaft_depth_pos+3,10],center=true);
        translate([0,10-shaft_depth_pos/2,5/2]) cube([10,shaft_depth_pos+8,5],center=true);
        translate([0,14,5/2]) cylinder(5,10/2,10/2,center=true);
      }
      translate([0,2,0]) rotate([180,0,90]) limit_switch(1);
    }
  }
  difference()
  {
    union()
    {
      translate([0,mount_thickness/2,0]) cube([length,mount_thickness,height],center=true);
      translate([shaft_side_pos,shaft_depth_pos,(height-guide_thicknes)/2]) shaft_guide(guide_thicknes,guide_diameter,rod_od);
      translate([shaft_side_pos,shaft_depth_pos,-(height-guide_thicknes)/2]) shaft_guide(guide_thicknes,guide_diameter,rod_od);
      translate([-shaft_side_pos,shaft_depth_pos,(height-guide_thicknes)/2]) shaft_guide(guide_thicknes,guide_diameter,rod_od);
      translate([-shaft_side_pos,shaft_depth_pos,-(height-guide_thicknes)/2]) shaft_guide(guide_thicknes,guide_diameter,rod_od);
      translate([shaft_side_pos+12,shaft_depth_pos-6,-22+5.6+6]) limit_holder();
    }
    translate([0,mount_thickness/2,0]) rotate([-90,0,0]) cylinder(mount_thickness+1,center_diameter/2,center_diameter/2,center=true);
    translate([screw_location,mount_thickness/2,screw_location]) rotate([-90,0,0]) cylinder(mount_thickness+0.1,screw_diameter/2,screw_diameter/2,center=true);
    translate([-screw_location,mount_thickness/2,screw_location]) rotate([-90,0,0]) cylinder(mount_thickness+0.1,screw_diameter/2,screw_diameter/2,center=true);
    translate([screw_location,mount_thickness/2,-screw_location]) rotate([-90,0,0]) cylinder(mount_thickness+0.1,screw_diameter/2,screw_diameter/2,center=true);
    translate([-screw_location,mount_thickness/2,-screw_location]) rotate([-90,0,0]) cylinder(mount_thickness+0.1,screw_diameter/2,screw_diameter/2,center=true);

    
  }
}

shaft_side_pos = 42/2+6;
shaft_depth_pos = 15;
drive_spacing = 0;
slide_height = 0;//30;

//linear_slide(shaft_side_pos,shaft_depth_pos-drive_spacing,1);

//HollowStepper1();
//slide_coller();
//anti_swivel_fitting();

module linear_unit()
{
  %translate([0,0,0]) rotate([-90,0,0]) NEMA17();
  %translate([shaft_side_pos,shaft_depth_pos,slide_height]) carbon_rod();
  %translate([-shaft_side_pos,shaft_depth_pos,slide_height]) carbon_rod();
  translate([0,drive_spacing,0]) linear_slide1(shaft_side_pos,shaft_depth_pos-drive_spacing,1);
  translate([0,drive_spacing,slide_height]) linear_slide1(shaft_side_pos,shaft_depth_pos-drive_spacing,2);
  %slide_mount(shaft_side_pos, shaft_depth_pos);
  %translate([shaft_side_pos+12,shaft_depth_pos-4,-22+5.6+6]) rotate([180,0,90]) limit_switch();

}

linear_unit();
