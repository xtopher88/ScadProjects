
track_width = 41.2;
rail_width = 6.45;
rail_spacing = 12.475;
//rail_inner = 18.5;
//rail_outer = 31.4;

track_thickness = 12.0;
rail_depth = 2.6;

female_width = 7.4 + 0.2+0.5;
female_length = 7.0;
female_diameter = 12.4 + 0.2+0.5;
female_depth = 17.8;

male_width = 6.2;
male_diameter = 11.0;
male_depth = 17.2;

module track_connection(track_length, track_with, connect_width, connect_diameter, connect_depth)
{
  //create the extra track length the rails are not removed here
  translate([track_length/2,0,track_thickness/2]) cube([track_length, track_with, track_thickness],center=true);
  //create the neck that extends to the center of the cylinder
  neck_length = connect_depth - connect_diameter/2;
  translate([track_length+neck_length/2,0,track_thickness/2]) cube([neck_length, connect_width, track_thickness],center=true);
  //create the locking cylinder
  translate([track_length+neck_length,0,track_thickness/2]) cylinder(track_thickness,connect_diameter/2,connect_diameter/2,center=true);
}

module track_grove(length)
{
  translate([length/2,0,track_thickness-rail_depth/2]) cube([length, rail_width, rail_depth],center=true);
  translate([length/2,rail_width/3,track_thickness-rail_depth/4]) rotate([70,0,0]) cube([length, rail_depth, rail_depth],center=true);
  translate([length/2,-rail_width/3,track_thickness-rail_depth/4]) rotate([-70,0,0]) cube([length, rail_depth, rail_depth],center=true);
}

female_offset = 5;
extra_length = 100.0;
extra_width = 25.0;

cutout_diameter=20;

nail_diameter=2;
nail_spacing1=20;
nail_spacing2=30;

module track_base(female_offset1 = 0)
{
  difference()
  {
    union()
    {
      // create the male track connect piece
      track_connection(extra_length+female_depth+female_offset1,
        track_width,
        male_width,
        male_diameter,
        male_depth);
    }
    // subtract out the female connection, and the track groves
    union()
    {
      track_connection(female_offset1,
        track_width+extra_width,
        female_width,
        female_diameter,
        female_depth);
      translate([0,-rail_spacing,0]) track_grove(extra_length+female_depth+female_offset1);
      translate([0,rail_spacing,0]) track_grove(extra_length+female_depth+female_offset1);
      
      cutout_length= extra_length+female_depth+female_offset1+male_depth;
      translate([cutout_length/2,0,0]) rotate([0,90,0]) cylinder(cutout_length,cutout_diameter/2,cutout_diameter/2,center=true);
      
      translate([cutout_length/2+nail_spacing1,-rail_spacing,0]) cylinder(30,nail_diameter/2,nail_diameter/2,center=true);
      translate([cutout_length/2+nail_spacing1,rail_spacing,0]) cylinder(30,nail_diameter/2,nail_diameter/2,center=true);
      translate([cutout_length/2-nail_spacing2,-rail_spacing,0]) cylinder(30,nail_diameter/2,nail_diameter/2,center=true);
      translate([cutout_length/2-nail_spacing2,rail_spacing,0]) cylinder(30,nail_diameter/2,nail_diameter/2,center=true);
      
    }
  }
}

module side_bracing(height, length, thickness, frame_thickness)
{
  //echo(height=height,length=length,thickness=thickness,frame_thickness=frame_thickness);
  //outer frame
  translate([frame_thickness/2,0,height/2]) cube([frame_thickness, thickness, height],center=true);
  //translate([length-frame_thickness/2,0,height/2]) cube([frame_thickness, thickness, height],center=true);
  translate([length/2,0,frame_thickness/2]) cube([length, thickness, frame_thickness],center=true);
  translate([length/2,0,height-frame_thickness/2]) cube([length, thickness, frame_thickness],center=true);
  //a bit tired, this is ugly sorry
  cb_shift = 0.72;
  cb_angle = 50;
  cb_length = height*0.745;
  translate([length/2,0,height*cb_shift]) rotate([0,cb_angle,0]) cube([frame_thickness, thickness, cb_length],center=true);
  translate([length/2,0,height*cb_shift]) rotate([0,-cb_angle,0]) cube([frame_thickness, thickness, cb_length],center=true);
  translate([length/2,0,height*(1-cb_shift)]) rotate([0,cb_angle,0]) cube([frame_thickness, thickness, cb_length],center=true);
  translate([length/2,0,height*(1-cb_shift)]) rotate([0,-cb_angle,0]) cube([frame_thickness, thickness, cb_length],center=true);
  
}

rotate([0,180,0])track_base();
 
