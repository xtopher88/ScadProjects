
module tunnel_cover()
{
  track_width = 40;
  max_car_width = 65;
  wall_height = 105;
  thickness = 5;
  length = 70;
  length = 140;
  
  top_height = 20;
  top_width = 40;
  slant_width = 50;
  
  window_width = 30;
  window_spacing = (length/2)/2;
  window_height = 10;
  difference()
  {
    union()
    {
      //walls
      translate([(max_car_width+thickness)/2,0,wall_height/2]) cube([thickness,length,wall_height],center=true);
      translate([-(max_car_width+thickness)/2,0,wall_height/2]) cube([thickness,length,wall_height],center=true);
      //bottom
      translate([0,0,thickness/2]) cube([max_car_width,length,thickness],center=true);
      //top
      translate([0,0,wall_height+top_height-3.75]) cube([top_width,length,thickness],center=true);
      //slant
      translate([(max_car_width-top_width)-thickness/2,0,wall_height+top_height/2+thickness/2]) rotate([0,45,0]) translate([18,0,0]) cube([slant_width,length,thickness],center=true);
      translate([-((max_car_width-top_width)-thickness/2),0,wall_height+top_height/2+thickness/2]) rotate([0,-45,0]) translate([-18,0,0]) cube([slant_width,length,thickness],center=true);
      
    }
    
    //track cutout
    translate([0,0,thickness/2]) cube([track_width,length+1,thickness+1],center=true);
    //windows
    translate([(max_car_width+thickness)/2,window_spacing,wall_height/2+window_height]) rotate([45,0,0]) cube([thickness+1,window_width,window_width],center=true);
    translate([(max_car_width+thickness)/2,-window_spacing,wall_height/2+window_height]) rotate([45,0,0]) cube([thickness+1,window_width,window_width],center=true);
    translate([-(max_car_width+thickness)/2,window_spacing,wall_height/2+window_height]) rotate([45,0,0]) cube([thickness+1,window_width,window_width],center=true);
    translate([-(max_car_width+thickness)/2,-window_spacing,wall_height/2+window_height]) rotate([45,0,0]) cube([thickness+1,window_width,window_width],center=true);
    
  }
}


tunnel_cover();
