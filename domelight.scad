

//sphere(r=50,$fn=6);

//wemos_d1_mini();

//cube([40,40,30], center=true);
crossy();

//translate([0,0,30]) center();
//ws_2812();
//arms();


module arms(){
    for(i=[0:6]){
        rotate([0,0,30 + i*60]) translate([70,0,5]) rotate([0,-11,0]) arm();
    }
}

module center(){
    translate([0,0,-10]) wemos_d1_mini();
    union(){
        translate([0,0,50*0.2+2]) scale([1,1,0.2]) sphere(r=50,$fn=6, center=true);
        cylinder(r=50,h=25,$fn=6, center=true);
    }
    rotate([90,0,0]) translate([0,-10,0]) battery_18650();
}

module arm(){
    translate([0,0,10]) ws_2812();
    difference(){
        cube([30,50,10], center=true);
    }
}


module wemos_d1_mini(){
    cube([34.2,25.6,2]);
}

module ws_2812(){
    color([0.9,0.9,0.9]) minkowski(){
        cube([8,8,1], center=true);
        cylinder(r=2,h=1);
        }
    translate([0,0,2]){
        difference(){
            color([1,1,1,0.5]) sphere(r=3);
            translate([0,0,-5]) cube([10,10,10], center=true);
        }
    }
}
module battery_18650(){
    cylinder(r =18.6/2, h=65, center=true);
}

module crossy(){
    for(i=[0:6]){
        rotate([90,0,0])  rotate([-11,i*60,0]) translate([0,0,220]){ 
            difference(){
                cylinder(r=16/2,h=400, center=true);
                //cylinder(r=(16/2 - 2),h=120,center=true);
            }
        }
    }
}