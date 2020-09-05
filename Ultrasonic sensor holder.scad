// Ultrasonic holder model, 4 Sep 2020
$fn=60;
sensor_radius=7.5;
sensor_diameter=sensor_radius*2;
thickness=2;
space_to_pcb = 5;
pcb_to_left_center = 3+sensor_radius;

module my_cyl() {cylinder(h=20,d=sensor_diameter);} // height of dummy cylinder can be smaller
module hole2mm(){cylinder(h=20,d=2);}               // was set to 20 when the width was 
module hole3mm(){cylinder(h=20,d=3);}               


module US_part(){
    union(){
        difference() {
            cube ([54,30,thickness]);
            translate([space_to_pcb+pcb_to_left_center,space_to_pcb+3+sensor_radius,-5]) my_cyl(); 
            translate([space_to_pcb+pcb_to_left_center+23,space_to_pcb+3+sensor_radius,-5]) my_cyl(); 
            translate([6.5   ,6.5   ,-5]) hole2mm();
            translate([6.5+42,6.5   ,-5]) hole2mm();
            translate([6.5   ,6.5+17,-5]) hole2mm();
            translate([6.5+42,6.5+17,-5]) hole2mm();
            }
            translate([17.5,-21,0]) cube ([20,21,thickness]);
            }   
}

difference() {
    US_part();
    for ( i = [0 : 4] ) {translate([27,15-(i*7),-5]) hole3mm();}
}

// the base
module base_1(_width) {
    difference() {
        cube([_width,37,thickness]);
        for (i = [5:7:37]){translate([55/2,i,-5]) hole3mm();}                      
    }
}

module base(_pole_width) {
    union(){
        difference(){
            translate ([70 ,0 ,0]) cube([55,40,thickness]);
            translate ([85 ,7 ,0]) hole3mm();
            translate ([110,7 ,0]) hole3mm();
            translate ([85 ,33,0]) hole3mm();
            translate ([110,33,0]) hole3mm();
        }        
        translate ([70,19,2]) rotate ([90,0,0])  base_1(_pole_width);        
    }    
}

base(55);
translate ([0 ,100 ,0]) base(15);
