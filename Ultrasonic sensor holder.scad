// Ultrasonic holder model, 4 Sep 2020
radius=7.5;
diameter=radius*2;
width=2;
space_to_pcb = 5;
pcb_to_left_center = 3+radius;

module my_cyl() {cylinder(h=20,d=diameter);}
module hole2mm(){cylinder(h=20,d=2);}
module hole3mm(){cylinder(h=20,d=3);}


module whole(){
    union(){
        difference() {
            cube ([54,30,width]);
            translate([space_to_pcb+pcb_to_left_center,space_to_pcb+3+radius,-5]) my_cyl(); 
            translate([space_to_pcb+pcb_to_left_center+23,space_to_pcb+3+radius,-5]) my_cyl(); 
            translate([6.5   ,6.5   ,-5]) hole2mm();
            translate([6.5+42,6.5   ,-5]) hole2mm();
            translate([6.5   ,6.5+17,-5]) hole2mm();
            translate([6.5+42,6.5+17,-5]) hole2mm();
            }
            translate([17.5,-21,0]) cube ([20,21,width]);
            }   
}

difference() {
    whole();
    for ( i = [0 : 3] ) {translate([27.5,7-(i*7),-5]) hole3mm();}
}

// the base
module base_1() {
    difference() {
        cube([55,40,width]);
        for (i = [5:6:37]){translate([55/2,i,-5]) hole3mm();}                      
    }
}

module base() {
    union(){
        difference(){
            translate ([70 ,0 ,0]) cube([55,40,width]);
            translate ([85 ,7 ,0]) hole3mm();
            translate ([110,7 ,0]) hole3mm();
            translate ([85 ,33,0]) hole3mm();
            translate ([110,33,0]) hole3mm();
        }
        
        translate ([70,19,10]) rotate ([90,0,0])  base_1();
        
    }
    

}

base();
