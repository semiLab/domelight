include <wemos_d1_mini.scad>
//translate([0,0,-30]) cube([150,150,5], center=true);

//"top", "bottom", "lid"
$fn=20;
//part = "top";

thing("top");
translate([0,0,-90]) thing("bottom");

translate([0,0,-200]) thing("lid");

windows();
translate([0,0,-80]) magnets();


//translate([-10,-8,15]) rotate([0,0,0]) wemos_d1_mini();


translate([-5,0,-180]){
//    batterypack();
}
module thing(type){
if(type=="lid"){
    battery_lid();
}else{
color([1,1,0.4,0.2]) difference(){
     shell();
    for(i=[0:2]){
       rotate([0,0,120* i]){ 
           translate([45,0,30]){ 
               rotate([0,76,0]){
                   difference(){
                    translate([0,0,1]) cube([32,32,40], center=true);
                    rotate([0,45,0]) translate([36,0,0])   cube([40,50,50], center=true);
                   }
                   //Window cutouts
rotate([0,45,0]) translate([-8,0,-2])   cube([30,34,40], center=true);
                  
                  //Wire cutouts 
                   if(type == "top"){
                   rotate([0,-45,0])translate([-2,14,-30]) cube([5,3,40], center=true); 
                   
                   rotate([0,-45,0])translate([-2,-14,-30]) cube([5,3,40], center=true);
                   }
                }
            }
        }
    }
    translate([-5,0,0]){
        batterybay();
    }
    translate([0,0,0]){
        magnets();
    }
    //Holes for screws
    //translate([0,0,0]) cylinder(r=1.6,h=50);
    if(type=="top"){
        bottomcutter();
    }else if(type=="bottom"){
        topcutter();
    }
}
}
}


//Cutting off the bottom for printing...
module bottomcutter(){
     translate([-100,-100,-100]) cube([200,200,100]);
    difference(){
    union(){
       
            
    
    hull(){
    translate([-16,-36,-1]) cube([42,72,8]);
    translate([-7,0,3]) scale([1.1,1.1,1.1]) batterypack();
        
    }
    hull(){
    translate([0,0,26]) rotate([0,0,180]) cylinder(r=30,h=20,$fn=3, center=true);
        for(i=[0:2]){
                rotate([0,0,120* i]) translate([16,0,-5]) cube([40,40,20], center=true);
            }
    }
    //Piezo hole
    translate([0,0,30]) cylinder(r=6.1,h=20, center=true);
   
    hull(){
        for(i=[0:2]){
                rotate([0,0,120* i]) translate([45,0,-5]) cube([38,48,20], center=true);
            }
        }
    }
    screwhole_risers();
     
    }
}    

//Cutting off the top for printing...
module topcutter(){
    difference(){
    union(){
        translate([-100,-100,5]) cube([200,200,100]);
hull(){
        for(i=[0:2]){
                rotate([0,0,120* i]) translate([40,0,5]) cube([30,38,20], center=true);
            }
        }
        difference(){
           translate([0,0,50])cube([200,200,100],center=true); 
        hull(){
        for(i=[0:2]){
                rotate([0,0,120* i]) translate([44.5,0,0]) cube([30,38,20], center=true);
            }
        }
    }
    }
    //Battery holder structure
    difference(){
        hull(){
            translate([-15,-35,-20]) cube([40,70,28]);
            translate([-6,0,3]) scale([1.1,1.1,1.1]) batterypack();
        }
        translate([-50,-50,10]) cube([100,100,20]);
       translate([2,33,5]) cube([6,10,10]);
        translate([2,-43,5]) cube([6,10,10]);
    }
    
    translate([0,0,-15]) screwhole_risers();
    
}
for(i=[0:2]){
                rotate([0,0,120* i]){
                    translate([45,15,-15]){
                        cylinder(r=2,h=20);
                        translate([0,0,-15]) cylinder(r=4,h=20);
                    }
                }
        }
}
module screwhole_risers(){
 //Risers for screw holes
    for(i=[0:2]){
                rotate([0,0,120* i]){
                    translate([45,15,-5]){
                        difference(){
                            cylinder(r=7,h=20);
                            cylinder(r=2,h=20);
                        }
                    }
                }
        }
}


module magnets(){
for(i=[0:2]){
    rotate([0,0,120* i]){ 
        translate([45,0,-7]) scale([1.1,1.1,1.1]) magnet();
    }
}
}


module windows(){
    for(i=[0:2]){
       rotate([0,0,120* i]){ 
           translate([45,0,30]){ 
               rotate([0,76,0]){ 
                  color([0.4,0,i/2,0.4]) rotate([0,45,0]) translate([5,0,0])   cube([3,32,38], center=true);
               }
           }
       }
   }
}  



module shell(){
    minkowski(){
        hull(){
            translate([0,0,30]) rotate([0,0,180]) cylinder(r=30,h=20,$fn=3, center=true);
            for(i=[0:2]){
                rotate([0,0,120* i]) translate([40,0,0]) cube([50,50,20], center=true);
            }
          
        }
        sphere(r=2, $fn=20);
    }
}
module batterybay(){
    $cutout_r = (18.6/2) + 0.5;
   rotate([90,0,0]){
    cylinder(r =$cutout_r, h=65+1, center=true);
    translate([20,0,0]) cylinder(r =(18.6/2) + 0.5, h=65+1, center=true);
   }
   translate([$cutout_r,0,-10]) cube([$cutout_r * 4, 66, $cutout_r*2], center=true);
   translate([$cutout_r,0,-20]) cube([$cutout_r * 4+2, 68, $cutout_r*2], center=true);
   
   //Finger cutout
   translate([-10,0,-20]) rotate([0,20,0]) cylinder(r=10,h=20,center=true);
   
   translate([25,15,-11]) cube([10,8,3]);
   translate([25,-20,-11]) cube([10,8,3]);
   
   translate([-12,-6,-8]) cube([10,12,2]);
   
   translate([-2,32.5,-35])battery_holder_cutout();
   translate([-2,-33.5,-35])battery_holder_cutout();
   
}

module battery_lid(){
    $cutout_r = (18.6/2) + 0.5;
color([0.5,0.5,0.5,0.2]) translate([-16.5,-33,-12]) cube([$cutout_r*4, 66, 2]);
     translate([20,15.5,-9.5]) cube([10,7,2.5]);
   translate([20,-19.5,-9.5]) cube([10,7,2.5]);
    translate([-16.5,-8,-11]) cube([3,16,7]);
    translate([-17,-6,-7]) rotate([0,10,0]) cube([3,12,2]);
}


module batterypack(){

    translate([0,0,0]) rotate([90,0,0]) battery_18650();
    translate([20,0,0]) rotate([90,0,0]) battery_18650();
}
module battery_holder_cutout(){
    cube([24,1.2,40]);
    translate([10,0,38]) cube([4,1.2,5]);
}

module battery_18650(){
    color([0,0,0.9]) cylinder(r =18.8/2, h=70, center=true);
}

module magnet(){
    color([0.8,0.8,0.8])  cube([10,10,5], center=true);
}