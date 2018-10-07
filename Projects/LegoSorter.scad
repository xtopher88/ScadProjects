//$fn=120*1.0;
module ring(length,od,id)
{
    difference()
    {
        cylinder(r=od/2,h=length,center=true);
        cylinder(r=id/2,h=length+0.1,center=true);
    }
}
    
module pvc_pipe(length = 100, od=33.3, id=25.6)
{
    ring(length,od,id);
}

module bearing(width = 7.0, od1=22.0, id1=19.0,od2=11.5,id2=8.0)
{
    union()
    {
        color("black") ring(width-1,od1-0.1,id2+0.1);
        color("silver") ring(width,od1,id1);
        color("silver") ring(width,od2,id2);
    }
}

module belt(length = 300,width = 100, id=34, thickness = 0.5)
{
    module solid_belt(length,width,id)
    {
        union()
        {
            translate([length/2,0,0]) cylinder(r=id/2,h=width,center=true);
            translate([-length/2,0,0]) cylinder(r=id/2,h=width,center=true);
            cube([length,id,width],center=true);
        }
    }
    difference()
    {
        solid_belt(length+thickness,width,id+thickness);
        solid_belt(length,width+0.1,id);
    }
}

module single_rail(length = 500)
{
  color("LightSlateGray") difference()
  {
    union()
    {
      cube([7.8,7.8,length],center=true);
      translate([0,(20-1.8)/2,0]) cube([20,1.8,length],center=true);
      translate([0,-(20-1.8)/2,0]) cube([20,1.8,length],center=true);
      translate([(20-1.8)/2,0,0]) cube([1.8,20,length],center=true);
      translate([-(20-1.8)/2,0,0]) cube([1.8,20,length],center=true);
      rotate([0,0,45]) cube([1.5,23,length],center=true);
      rotate([0,0,-45]) cube([1.5,23,length],center=true);
      translate([(20-4.5)/2,(20-4.5)/2,0]) cube([4.5,4.5,length],center=true);
      translate([(20-4.5)/2,-(20-4.5)/2,0]) cube([4.5,4.5,length],center=true);
      translate([-(20-4.5)/2,(20-4.5)/2,0]) cube([4.5,4.5,length],center=true);
      translate([-(20-4.5)/2,-(20-4.5)/2,0]) cube([4.5,4.5,length],center=true);
    }
    cylinder(length+1,3.9/2,3.9/2,center=true);
    translate([0,10,0]) rotate([0,0,45]) cube([6.72,6.75,length+1],center=true);
    translate([0,-10,0]) rotate([0,0,45]) cube([6.72,6.75,length+1],center=true);
    translate([10,0,0]) rotate([0,0,45]) cube([6.72,6.75,length+1],center=true);
    translate([-10,0,0]) rotate([0,0,45]) cube([6.72,6.75,length+1],center=true);
  }
}

// the pvc mount connects 608 bearing into the end of a 1" PVC pipe
module pvc_mount()
{
    od_pipe = 33.3;
    id_pipe = 25.6;
    od_bearing = 22.0 + 0.6;
    od1_bearing = 19.0;
    pipe_lip = 2.0;
    bearing_depth = 6.5;
    bearing_lip = 2.0;
    bearing_lip_slope = 1.5;
    
    difference()
    {
        union()
        {
            cylinder(r=id_pipe/2,h=bearing_depth+bearing_lip,center=true);
            translate([0,0,(bearing_depth-(pipe_lip-bearing_lip))/2])  cylinder(r=od_pipe/2,h=pipe_lip,center=true);
        }
        cylinder(r=od1_bearing/2,h=bearing_depth+bearing_lip+1,center=true);
        translate([0,0,bearing_lip/2]) cylinder(r1=od_bearing/2,r2=od_bearing/2,h=bearing_depth+0.1,center=true);
        translate([0,0,-(bearing_depth-bearing_lip_slope)/2]) cylinder(r1=od_bearing/2-bearing_lip_slope,r2=od_bearing/2,h=bearing_lip/2,center=true);
    }
}

module pvc_gear()
{
    pulley ( "GT2 2mm" , GT2_2mm_pulley_dia , 0.764 , 1.494 );
}

width = 150;
spacing = 300;
translate([(width-15)/2,0,0]) single_rail(250);
translate([-(width-15)/2,0,0]) single_rail(250);
translate([0,0,spacing/2]) rotate([0,90,0]) pvc_pipe(width);
translate([0,0,-spacing/2]) rotate([0,90,0]) pvc_pipe(width);
//translate([(width+4)/2,0,-spacing/2]) rotate([0,90,0]) bearing();
translate([(width-2)/2,0,-spacing/2]) rotate([0,90,0]) color("blue") pvc_mount();
//translate([(width+4)/2,0,spacing/2]) rotate([0,90,0]) bearing();
translate([(width-2)/2,0,spacing/2]) rotate([0,90,0]) color("blue") pvc_mount();
//rotate([0,180,0]) pvc_mount();
color("lightblue") rotate([0,90,0]) %belt(spacing, width);
// rotate([0,90,0]) %belt();