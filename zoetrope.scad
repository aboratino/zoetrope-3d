//
// Zoetrope - Anthony Boratino 2018
//  Prototype Zoetrope suitable for placing on a record player
//  Each frame consists of a growing dot.
//

$fn = 100;

n_frames = 30;
frame_angle = 360 / n_frames;

// Base Plate
bp_height = 3;
bp_radius = 140;
bp_hole_radius = 87;

// Frame dimensions
f_depth = 4;
f_width = 30;
f_slit = f_width-6;
f_bottom_height = 30;
f_slit_height = 30;
f_rad = 137;
f_dot_height = 8;
f_dot_rad = f_rad-5;

// A single frame
module frame( dot_rad )
{
    translate( [ f_rad, 0, f_bottom_height/2 ]) 
    cube( [ f_depth, f_width, f_bottom_height ], center=true );
    
    translate( [ f_rad, 0, f_slit_height/2 + f_bottom_height ] ) 
    cube( [ f_depth, f_slit, f_slit_height ], center=true );

    // Place dots ( cylinders with holes )
    difference()
    {
        translate( [ f_dot_rad, 0, f_bottom_height/2 ] ) 
        rotate( [ 0, 90, 0 ] ) 
        cylinder( f_dot_height, r=dot_rad+2 );
        
        translate( [ f_dot_rad-1, 0, f_bottom_height/2 ] )
        rotate( [ 0, 90, 0 ] )
        cylinder( f_dot_height+2, r=1 );
    }
}

// Base Plate
difference()
{
    translate( [ 0, 0, 0 ] )
    cylinder( bp_height, r=bp_radius, center=true );
    // cut a hole
    translate( [ 0, 0, bp_height-3 ] )
    cylinder( bp_height+3, r=bp_hole_radius, center=true );
}

// Create the frames 
for( i = [ 0 : n_frames ] )
{
    rotate( [ 0, 0, i*frame_angle ] ) 
    frame( i/5 );
}
