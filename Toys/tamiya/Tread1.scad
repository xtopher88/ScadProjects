
$fn=60;

module bolt()
{
    screw_d = 2;
    screw_length = 30;
    head_d = 4;
    head_length = 2;
    union()
    {
        translate([0,0,screw_length/2]) cylinder(screw_length,screw_d/2,screw_d/2,center=true);
        translate([0,0,-head_length/2]) cylinder(head_length,head_d/2,head_d/2,center=true);
    }
}

module tread_segment()
{  
    spacing = 15.0;
    mount_width = 4;
    mount_height = 6;
    thread_id = 2.4;
    slip_id = 3.0;
    
    width1 = 30 - mount_width;
    width2 = width1-(mount_width*2)-1.5;
    
    track_thickness = 2.5;
    tread_gap = 1;
    hinge_space = mount_height+4;
    
    
    module v_grove()
    {
        gap = 2.5;
        length = 40;
        rotate([0,0,45]) translate([(length-gap)/2,0,0]) cube([length,gap,track_thickness],center=true);
        rotate([0,0,-45]) translate([(length-gap)/2,0,0]) cube([length,gap,track_thickness],center=true);
    }
    
    module tread_base()
    {
        tread_width = 30 + 2*10;
        tread_length = spacing - tread_gap;
        difference()
        {
            union()
            {
                cube([tread_length,tread_width,track_thickness],center=true);
                translate([0,(tread_width-track_thickness)/2,track_thickness]) cube([tread_length,track_thickness,track_thickness],center=true);
                translate([0,-(tread_width-track_thickness)/2,track_thickness]) cube([tread_length,track_thickness,track_thickness],center=true);
            }
            translate([tread_length-3,0,track_thickness]) rotate([0,0,5]) cube([tread_length/2,tread_width*2,track_thickness*3+0.1],center=true);
            translate([tread_length-3,0,track_thickness]) rotate([0,0,-5]) cube([tread_length/2,tread_width*2,track_thickness*3+0.1],center=true);
            translate([-tread_length+3,0,track_thickness]) rotate([0,0,5]) cube([tread_length/2,tread_width*2,track_thickness*3+0.1],center=true);
            translate([-tread_length+3,0,track_thickness]) rotate([0,0,-5]) cube([tread_length/2,tread_width*2,track_thickness*3+0.1],center=true);
            
            //translate([0,0,-track_thickness+0.4]) cube([1,tread_width,track_thickness],center=true);
            
            translate([0,0,-track_thickness+0.8]) v_grove();
            translate([-10,0,-track_thickness+0.8]) v_grove();
            translate([-20,0,-track_thickness+0.8]) v_grove();
        }
    }
    
    
    module bolt_mount(length = 10, id=slip_id)
    {
        mount_height1 = mount_height + 3;
        difference()
        {
            union()
            {
                translate([-(length-mount_height/2)/2,0,0]) cube([length-mount_height/2,mount_width,mount_height],center=true);
                //translate([0,0,-mount_height/2+1]) rotate([0,45,0]) translate([0,0,-1]) cube([mount_height/2,mount_width,mount_height-1],center=true);
                translate([-1.5,0,0]) difference()
                {
                    rotate([90,0,0]) cylinder(mount_width,mount_height1/2,mount_height1/2,center=true);
                    translate([0,0,mount_height1/4]) cube([mount_height1,mount_width+0.1,mount_height1/2],center=true);
                }
                rotate([90,0,0]) cylinder(mount_width,mount_height/2,mount_height/2,center=true);
            }
            rotate([90,0,0]) cylinder(mount_width+0.1,id/2,id/2,center=true);
        }
    }
    difference()
    {
        union()
        {
            translate([spacing/2,width1/2,0]) bolt_mount();
            translate([spacing/2,-width1/2,0]) bolt_mount(id=2.2);
            translate([-spacing/2,width2/2,0]) rotate([0,0,180]) bolt_mount();
            translate([-spacing/2,-width2/2,0]) rotate([0,0,180]) bolt_mount();
            //manual configured cross pieces
            translate([0,(width1+width2)/4,0]) rotate([0,0,55]) cube([8,mount_width,mount_height],center=true);
            translate([0,-(width1+width2)/4,0]) rotate([0,0,-55]) cube([8,mount_width,mount_height],center=true);
            //base track
            translate([0,0,-(mount_height+track_thickness)/2]) tread_base();
            
        }
        //cutoff base
        translate([0,0,-(mount_height+track_thickness*3)/2]) cube([100,100,track_thickness],center=true);
        //cutout space for opposate hinges
        translate([spacing/2,width2/2,0]) rotate([90,0,0]) cylinder(mount_width+1,hinge_space/2,hinge_space/2,center=true);
        translate([spacing/2,-width2/2,0]) rotate([90,0,0]) cylinder(mount_width+1,hinge_space/2,hinge_space/2,center=true);
        translate([-spacing/2,width1/2,0]) rotate([90,0,0]) cylinder(mount_width+1,hinge_space/2,hinge_space/2,center=true);
        translate([-spacing/2,-width1/2,0]) rotate([90,0,0]) cylinder(mount_width+1,hinge_space/2,hinge_space/2,center=true);
    }
}

module drive_gear()
{
    
inner_diameter = 5.5;
inner_length = 5.0;
inner_width = 2.2;
    
    bolt_d = 3;
    sp = 15;
    width = 11;
    width1 = 8;
    wheel_diameter = sqrt(pow(sp,2)+pow(sp*(1+2/sqrt(2)),2));
    wheel_diameter1 = wheel_diameter + 3;
    echo(wheel_diameter=wheel_diameter);
    module cutout()
    {
        difference()
        {
            union()
            {
                cylinder(width+0.1,bolt_d/2,bolt_d/2,center=true);
                cube([bolt_d/2,bolt_d*2,width+0.1],center=true);
            }
            translate([-bolt_d/3,bolt_d*.9,0]) cylinder(width+0.1,bolt_d/2,bolt_d/2,center=true);
            translate([-bolt_d/3,-bolt_d*.9,0]) cylinder(width+0.1,bolt_d/2,bolt_d/2,center=true);
        }
    }
    difference()
    {
        union()
        {
            cylinder(width1,wheel_diameter1/2,wheel_diameter1/2,center=true);
            translate([0,0,(width-(width-width1)/2)/2]) cylinder((width-width1)/2,wheel_diameter1/2,wheel_diameter/2,center=true);
            translate([0,0,-(width-(width-width1)/2)/2]) cylinder((width-width1)/2,wheel_diameter/2,wheel_diameter1/2,center=true);
        }
        for(i=[0:8])
        {
            rotate([0,0,i*360/8]) translate([(wheel_diameter+bolt_d/2)/2,0,0]) cutout();
        }
        cylinder(5, inner_diameter/2,inner_diameter/2,center=true);
        cube([inner_length,inner_width, width+0.1],center=true);
        cube([inner_width, inner_length, width+0.1],center=true);
    }
}

module drive_gear1(num_teeth = 5)
{
    base_width = 10.0;
    base_length = 13.0;
    top_width = 9;
    top_length = 9;
    height = 3;
    module gear_tooth()
    {
        Points = [
        [ -base_width/2, -base_length/2,  0 ],  //0
        [ base_width/2,  -base_length/2,  0 ],  //1
        [ base_width/2,  base_length/2,  0 ],  //2
        [ -base_width/2, base_length/2,  0 ],  //3
        [ -top_width/2, -top_length/2,  height ],  //4
        [ top_width/2,  -top_length/2,  height ],  //5
        [ top_width/2,  top_length/2,  height ],  //6
        [ -top_width/2, top_length/2,  height ]]; //7
        Faces = [
        [0,1,2,3],  // bottom
        [4,5,1,0],  // front
        [7,6,5,4],  // top
        [5,6,2,1],  // right
        [6,7,3,2],  // back
        [7,4,0,3]]; // left
        rotate([0,0,90]) polyhedron( Points, Faces );
    }
    
    spacing = 15;
    cutout_d = 3.5;
    
    inner_diameter = 5.5;
    inner_length = 5.0;
    inner_width = 2.2;
    
    diameter = (spacing)/sin(360/(num_teeth*2));
    tooth_d = (spacing/2)/tan(360/(num_teeth*2));
    difference()
    {
        union()
        {
            rotate([90,0,0]) cylinder(base_width, diameter/2,diameter/2,center=true);
        
            for(i=[0:num_teeth])
            {
                rotate([0,i*(360/num_teeth),0]) translate([0,0,tooth_d]) gear_tooth();
            }
        }
        for(i=[0:num_teeth])
        {
            rotate([90,0,0])  rotate([0,0,(i+0.5)*(360/num_teeth)])  translate([0,diameter/2,0]) cylinder(base_width+0.1, cutout_d/2,cutout_d/2,center=true);
        }
        rotate([90,0,0]) cylinder(base_width-6, inner_diameter/2,inner_diameter/2,center=true);
        rotate([90,0,0]) cube([inner_length,inner_width, base_width+0.1],center=true);
        rotate([90,0,0]) cube([inner_width, inner_length, base_width+0.1],center=true);
    }
}

//translate([15/2,30/2,0]) rotate([90,0,0]) bolt();
//tread_segment();
rotate([90,0,0]) drive_gear1(7);