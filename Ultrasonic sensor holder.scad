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
            cube ([54,30,thickness]); // main body of US sensor
            translate([space_to_pcb+pcb_to_left_center,space_to_pcb+3+sensor_radius,-5]) my_cyl(); 
            translate([space_to_pcb+pcb_to_left_center+23,space_to_pcb+3+sensor_radius,-5]) my_cyl(); 
            translate([6.5   ,6.5   ,-5]) hole2mm();
            translate([6.5+42,6.5   ,-5]) hole2mm();
            translate([6.5   ,6.5+17,-5]) hole2mm();
            translate([6.5+42,6.5+17,-5]) hole2mm();
            }
            leg_length = 17;
            translate([17.5,-leg_length,0]) cube ([20,leg_length,thickness]); // base with holes
            }   
}

difference() {
    US_part();
    for ( i = [0 : 4] ) {translate([27,15-(i*7),-5]) hole3mm();}
}

// the base
module base_pole(_width,_height) {
    difference() {
        cube([_width,_height,thickness]);
        for (i = [5:7:37]){translate([_width/2,i,-5]) hole3mm();}                      
    }
}

module base(_base_width, _pole_width,_pole_height) {
    union(){
        difference(){
            translate ([70 ,0 ,0]) cube([55,40,thickness]);
            translate ([85 ,7 ,0]) hole3mm();
            translate ([110,7 ,0]) hole3mm();
            translate ([85 ,33,0]) hole3mm();
            translate ([110,33,0]) hole3mm();
        }
        // calc shifting the pole due to different width
        shift=(_base_width-_pole_width)/2;
        
        
        translate ([70+shift,19,2]) rotate ([90,0,0])  base_pole(_pole_width,_pole_height);        
    }    
}

// wide base version
base(55,55,37);

// narrow base version
translate ([0 ,100 ,0]) base(55,6,37);
translate ([0 ,100 ,0]) base(55,16,25); // these 2 lines overlap to allow wider base of pole and narrow 
