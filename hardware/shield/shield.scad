$fn=64;

mount_hole = [[2.35, 21.175],
              [18.15, 21.175],
              [2.35, 68.675],
              [18.15, 68.675],];

module outline_dxf(){
  import("./keyboard_left-Edge_Cuts.dxf");
};

module solder_dxf(){
  import("./keyboard_left-User_Drawings.dxf");
};


module trrs_dxf(){
  import("./keyboard_left-F_Silkscreen.dxf");
};

module usb_dxf(){
  import("./keyboard_left-Margin.dxf");
};


module mount_holes(){
  dia = 2.5;
  depth = 3.6;
    union(){
    for (pos = mount_hole){
      translate( [pos[0], -pos[1], 0])
        color("cyan")
        cylinder(d=dia, h=depth, center=true);
      }
    };
}

module core(){
  difference(){
    linear_extrude(5)
      outline_dxf();
    color("green")
    linear_extrude(2.5)
      solder_dxf();
    color("red")
    linear_extrude(5)
      trrs_dxf();
    color("blue")
    linear_extrude(3.5)
      usb_dxf();
    mount_holes();
  }
}

render(){
  core();
}
