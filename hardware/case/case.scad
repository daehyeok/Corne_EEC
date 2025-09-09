include <BOSL2/std.scad>
    $fn=64;

    
margin = 5;

//TODO - height
bottom_thickness = 1.5;
bottom_space = 1.5;

pcb_thickness = 1.6;
pcb_top_height = bottom_thickness + pcb_thickness;

plate_thickness = 1.2;
plate_bottom_height = pcb_top_height + 5;
plate_top_height = plate_bottom_height + plate_thickness;

echo("plate_top_height", plate_top_height);
echo("plate_top_height", plate_top_height);

wall_height = plate_bottom_height;

debug_jst_post= [121.773, 20.355];

outside_mount_points = [
    [0, 11.625],
    [57, 18.625],
    [95,13.875],
    [0,-68.628808],
    [57.763898,-83.378808],
    [94.088898,-87.978808],
    [120.195842, -83.267293]
    
];
outside_mount_hole_dia = 1.61;

echo("pcb_top_height", pcb_top_height);

usb_center_height = 3.26/2;
usb_pos = [118.05,  11.375, pcb_top_height + usb_center_height];
//TODO fix value
usb_cutout_height = 6.5;
usb_cutout_width = 11.6;
usb_port_entry_width=11;


trrs_dia = 5.6;
trrs_radius = trrs_dia /2 ;
//x_pos == pcb_edge
trrs_pos = [124.75, -4.025, pcb_top_height +  trrs_radius];
//TODO fix value
trrs_cutout_dia = 7.5;

reset_center = 3.2/2;
reset_center_height = pcb_top_height + reset_center;
//y_pos == pcb_edge
reset_sw_pos = [108.65, 11.375, reset_center_height];
reset_dia = 2;
reset_cut_dia = 4;

//mount screw positions
m2_mount_pos = [ [0, 9.5],
                 [0, 47.5],
                 [38, 23.75],
                 [76, 23.75],
                 [95, 7.125],
                 [57, 71.875],
                 [100.9654, 68.4478],
                 ];
m2_screw_hole_dia = 2.1;



module pcb_outline_dxf(){
  import("./kicad/case-Edge_Cuts.dxf");
};


module core(){
  down(bottom_thickness)
  union(){    
    linear_extrude(bottom_thickness)
        minkowski()
    {
      pcb_outline_dxf();
      circle(r=0.2);
    };
    linear_extrude(wall_height + bottom_thickness)
        difference(){
      minkowski()
      {
        pcb_outline_dxf();
        circle(r=margin);
      };
      pcb_outline_dxf();
    }
  }
}

module mount_cutout(){
  head_hole_dia = 4.5;
  head_hole_depth = 0.5;

  color("green")
  union(){
    for (pos = m2_mount_pos){
          move([pos[0], -pos[1], -bottom_thickness])
          union(){
        cylinder(d=head_hole_dia, h=head_hole_depth);
        cylinder(d=m2_screw_hole_dia, h=10);
      }
    }};
}

module outside_mount_cutout(){
  head_hole_dia = 3;
  head_hole_depth = 0.5;

  color("green")
  union(){
    for (pos = outside_mount_points){
          move( concat(pos,  -bottom_thickness))
          union(){
        cylinder(d=head_hole_dia, h=head_hole_depth);
        cylinder(d=outside_mount_hole_dia, h=30);
      }
    }};
}

module bottom_spacer(){
  color("blue")
  union(){
    for (pos = m2_mount_pos){
      move([pos[0], -pos[1]])
     difference(){
        cylinder(d=bottom_spacer_dia, h=bottom_spacer_thickness);
      }
    }
  };
}

//TODO recheck
module usb_cut_out(){
  move(usb_pos)
      color("green")
      union(){
      cuboid([usb_cutout_width, 20, usb_cutout_height], rounding=0.5);
      left(usb_cutout_width/2)
      down(3.26/2 + 1)
          cube([usb_port_entry_width, 1.5, 20]);
  }
}

//TODO
module trrs_cut_out(){
  move(trrs_pos)
      color("green")
      union(){
       cube([20, trrs_cutout_dia, 10], center=true);
  }
}

module reset_cut_out(){

large_hole_dia =reset_cut_dia + 2;
upside_entry_width=1.8;
y_cut = 10;
move(reset_sw_pos)
    color("green")
    union(){
    up(y_cut/2 - large_hole_dia/2)
    back(upside_entry_width/2)
        cube([large_hole_dia, upside_entry_width, y_cut], center = true);
        xrot(-90)
        union(){
            cylinder(d=reset_cut_dia, h = 10);
        }
    }
}   

module case(){
  difference(){
    union(){
      core();
    }
    //mount_cutout();
    usb_cut_out();
    trrs_cut_out();
    reset_cut_out();
    outside_mount_cutout();
  }
}

render(){
  case();
}
