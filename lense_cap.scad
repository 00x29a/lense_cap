/////////////
//
// Lense Cap for Lumix 14-42 Lense
// Micro Four Thirds
//
// author: 00x29a
// 
// "still learning, be nice"
// constructive critisism is welcome
//
/////////////


// PARAMETERS

// facets
$fa=1;

// internal
// with .1 mm added for 

internal_diam   = 56.1; 
internal_height = 5.3;
tabs_diam       = 58.2;
tabs_width      = 28.6;
tabs_thick      = 1.7;
tabs_height     = 3.2;


// external
material = 4;

text_radius = 21;
chars = "00x29a!          ";

// EXECUTE


difference(){
    shellExterior(internal_diam,material,internal_height);
    internalCut(internal_diam,internal_height,tabs_width,tabs_diam,tabs_height,tabs_thick);
    translate([0,0,internal_height+material-.8])linear_extrude(2)
    revolveText(text_radius,chars); // unneccessary, just for fun 
    translate([0,0,internal_height+material-.8])
    scale([.08,.08,1])rotate([0,0,-160])
    linear_extrude(2)import("l_s.svg",$fn=100,center=true); // also unneccessary

}


//textCut();



// MODULES

module revolveText(radius, chars) {
    PI = 3.14159;
    circumference = 2 * PI * radius;
    chars_len = len(chars);
    font_size = circumference / chars_len;
    step_angle = 360 / chars_len;
    for(i = [0 : chars_len - 1]) {
        rotate(-i * step_angle) 
            translate([0, radius + font_size / 2, 0]) 
                text(
                    chars[i], 
                    font = "Faxfont Tone:style=Regular", 
                    size = font_size+6, 
                    valign = "center", halign = "center"
                );
    }
}


module shellExterior(id,m,ih){
    difference(){
        union(){
            cylinder(h=ih+m,d=id+m*2);
        }
        union(){
            bh = ih+m; // knurling height
            
            //top chamfer
            translate([0,0,bh])
            rotate_extrude()
            translate([id*.5+m,0])
            circle(r=1.1,$fn=4);

            //bottom chamfer
            rotate_extrude()
            translate([id*.5+m,0])
            circle(r=1.1,$fn=4);
            
            //knurling
            for(i=[0:50])
            rotate([0,0,i*8])
            linear_extrude(height=bh+0.1,twist=500*(bh/140))
            translate([id*.5+m,0])
            circle(r=1.2,$fn=4);

            //knurling
            for(i=[0:50])
            rotate([0,0,i*8])
            linear_extrude(height=bh+0.1,twist=-500*(bh/140))
            translate([id*.5+m,0])
            circle(r=1.2,$fn=4); 

        }
    }
}

module internalCut(id,ih,tw,td,th,tt){
    translate([0,0,-.002]){
        cylinder(h = ih, d = id);
        union(){      // first tab cut
            intersection(){
                union(){
                    rotate([0,0,-30])translate([0,0,th-tt*.5])cube([20,td,tt],center=true);
                    translate([0,0,th*.5])cube([20,td,th],center=true);
                }
                cylinder(d=td, h=th);
            }
        }
    }
}






