include <BOSL2/std.scad>;
$fn=64;

margin = 5;

//TODO - height
bottom_thickness = 1.5;
bottom_space = 1.5;

pcb_thickness = 1.6;
pcb_top_height = pcb_thickness;

plate_thickness = 1.2;
plate_bottom_height = pcb_top_height + 5;

standoff_height = 5;
wall_height = pcb_thickness + standoff_height + plate_thickness;

debug_jst_post= [121.773, 20.355];

usb_center_height = 3.26/2;
usb_pos = [118.05,  11.375];
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
m2_mount_pos = [ [38, -23.75],
                 [76, -23.75],
                 [57, -71.875],
                 ];

plate_mount_pos = [ [0, -9.5],
                    [0, -47.5],
                    [95, -7.125],
                    [100.9654, -68.4478],
                    ];

m2_screw_hole_dia = 2.05;



module pcb_outline_dxf(){
  import("./kicad/case-Edge_Cuts.dxf");
};

module pcb_cut_outline(){
  minkowski()
    {
      pcb_outline_dxf();
      circle(r=0.01);
    };
};


module case_outline(){
  minkowski()
    {
      pcb_outline_dxf();
      circle(r=margin);
    };
}

module bottom(){
  down(bottom_thickness)
    linear_extrude(bottom_thickness)
    pcb_cut_outline();
}

module wall(){
  down(bottom_thickness)
    linear_extrude(wall_height+bottom_thickness)
    difference(){
    case_outline();
    pcb_cut_outline();
  }
}

module core(){  
  union(){
    bottom();
    wall();
  }
}

module mount_cutout(){
  head_hole_dia = 4.5;
  head_hole_depth = 1;

  color("green")
    union(){
    for (pos = m2_mount_pos){
      move( concat(pos))
        down(bottom_thickness + 2)
        zrot(90)
        cylinder(d=m2_screw_hole_dia, h=10);
    }};
}

module plate_mount_cutout(){
  head_hole_dia = 4.5;
  head_hole_depth = 1;

  color("green")
    union(){
    for (pos = plate_mount_pos){
      move( concat(pos))
        down(head_hole_depth)
        zrot(-90)
        cylinder(d=head_hole_dia, h=head_hole_depth);
    }};
}


module usb_cutout_shape(){
  usb_extrude = 2;
  color("green")
    union(){
    up(pcb_thickness+0.5)
      left(usb_cutout_width/2)
      cube([usb_cutout_width, usb_extrude, 20]);
    up(usb_center_height + pcb_thickness)
      cuboid([usb_cutout_width, 20, usb_cutout_height], rounding=0.5);
  }
}
//TODO recheck
module usb_cut_out(){
  move(usb_pos)
    usb_cutout_shape();
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
    usb_cut_out();
    trrs_cut_out();
    reset_cut_out();
    mount_cutout();
    plate_mount_cutout();
  }
}

render(){
  case();
  usb_cutout_shape();
}
