module spice_rack()
{
    inner_length = 143;
    inner_depth = 48;
    height = 60;
    back_height = 90;
    wall_thinkness = 3;
    bottom_thickness = 5;
    screw_d =3;
    
    module wall(length,width,thickness,slat_thickness,num_cutout_pairs)
    {
        wall_segments = slat_thickness * (1+2*num_cutout_pairs);
        length_cutout = (length-wall_segments)/(2*num_cutout_pairs);
        module cutout(c_width,c_height)
        {
            width_2 = c_width * sqrt(2) / 2;
            translate([0,0,0]) cube([c_width,c_height-c_width-slat_thickness*2,thickness+.1], center = true);
            translate([0,c_height/2-c_width/2-slat_thickness,0]) rotate([0,0,45]) cube([width_2,width_2,thickness+.1], center = true);
            translate([0,-(c_height/2-c_width/2-slat_thickness),0]) rotate([0,0,45]) cube([width_2,width_2,thickness+.1], center = true);
        }
        difference()
        {
            cube([length,width,thickness],center=true);
            for( i=[1:num_cutout_pairs])
            {
                translate([(i-1)*(length_cutout+slat_thickness)+(length_cutout+slat_thickness)/2,0,0]) cutout(length_cutout,width);
                translate([-(i-1)*(length_cutout+slat_thickness)-(length_cutout+slat_thickness)/2,0,0]) cutout(length_cutout,width);
            }
        }
    }
    module side_wall(length,width,width1,thickness,slat_thickness)
    {
        wall_segments = slat_thickness * (1+2);
        length_cutout = (length-wall_segments)/(2);
        module cutout(c_width,c_height)
        {
            width_2 = c_width * sqrt(2) / 2;
            translate([0,0,0]) cube([c_width,c_height-c_width-slat_thickness*2,thickness+.1], center = true);
            translate([0,c_height/2-c_width/2-slat_thickness,0]) rotate([0,0,45]) cube([width_2,width_2,thickness+.1], center = true);
            translate([0,-(c_height/2-c_width/2-slat_thickness),0]) rotate([0,0,45]) cube([width_2,width_2,thickness+.1], center = true);
        }
        difference()
        {
            translate([0,(width1-width)/2,0]) cube([length,width1,thickness],center=true);
            translate([0,width+(width1-width)/2,0]) rotate([0,0,atan2((width1-width),length)]) cube([length*2,length,thickness+0.1],center=true);
            average_width = (width1+width)/2;
                translate([(length_cutout+slat_thickness)/2,(width1-width)*2/8,0]) cutout(length_cutout,average_width);
                translate([-(length_cutout+slat_thickness)/2,0,0]) cutout(length_cutout,width);
        }
    }
    
    union()
    {
        difference()
        {
            // back wall
            translate([0,back_height/2,0]) wall(inner_length+wall_thinkness*2,back_height,wall_thinkness,8,3);
            screw_offset = 5;
            // screw holes
            translate([(inner_length+wall_thinkness)/2-screw_offset,back_height-wall_thinkness/2-screw_offset,0]) cylinder(wall_thinkness+0.01,screw_d/2,screw_d,center=true);
            translate([-((inner_length+wall_thinkness)/2-screw_offset),back_height-wall_thinkness/2-screw_offset,0]) cylinder(wall_thinkness+0.01,screw_d/2,screw_d,center=true);
        }
        difference()
        {
            corner_offset = 1.5;
            union()
            {
                // front wall
                translate([0,height/2,inner_depth+wall_thinkness*2]) wall(inner_length+wall_thinkness*2,height,wall_thinkness,8,3);
                // corner additions for cutouts
                translate([inner_length/2-corner_offset,height/2,inner_depth+wall_thinkness*3/2-corner_offset]) rotate([0,45,0]) cube([wall_thinkness*2.5,height,wall_thinkness], center = true);
                translate([-(inner_length/2-corner_offset),height/2,inner_depth+wall_thinkness*3/2-corner_offset]) rotate([0,-45,0]) cube([wall_thinkness*2.5,height,wall_thinkness], center = true);
                // side walls
                translate([inner_length/2+wall_thinkness/2,height/2,inner_depth/2+wall_thinkness]) rotate([0,90,0]) side_wall(inner_depth+wall_thinkness*2,height,back_height,wall_thinkness,8);
                translate([-(inner_length/2+wall_thinkness/2),height/2,inner_depth/2+wall_thinkness]) rotate([0,90,0]) side_wall(inner_depth+wall_thinkness*2,height,back_height,wall_thinkness,8);
                // bottom
                translate([0,wall_thinkness/2,inner_depth/2+wall_thinkness]) rotate([90,0,0]) wall(inner_length+wall_thinkness*2,inner_depth+wall_thinkness*2,wall_thinkness,8,4);
            }
            // corner cutouts
            translate([inner_length/2-corner_offset,height/2,inner_depth+wall_thinkness*3/2-corner_offset]) rotate([0,45,0]) translate([0,0,wall_thinkness*3/2]) cube([wall_thinkness*4,height+10,wall_thinkness*2], center = true);
            // corner cutouts
            translate([-(inner_length/2-corner_offset),height/2,inner_depth+wall_thinkness*3/2-corner_offset]) rotate([0,-45,0]) translate([0,0,wall_thinkness*3/2]) cube([wall_thinkness*4,height+10,wall_thinkness*2], center = true);
        }
    }
}

rotate([90,0,0]) spice_rack();