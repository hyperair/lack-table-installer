use <MCAD/fasteners/nuts_and_bolts.scad>
use <MCAD/shapes/polyhole.scad>
use <MCAD/shapes/2Dshapes.scad>
include <MCAD/units/metric.scad>

leg_dimensions = [51, 51];
wall_thickness = 8;
base_thickness = 13;
depth = 50;

bolt_size = M6;
clearance = 0.3;

socket_dimensions = concat (leg_dimensions + [1, 1] * wall_thickness,
    [base_thickness + depth]);
socket_inner_dimensions = concat (leg_dimensions, [depth + epsilon]);

difference () {
    ccube (socket_dimensions, center = X + Y);

    translate ([0, 0, base_thickness])
    ccube (socket_inner_dimensions, center = X + Y);

    translate ([0, 0, -epsilon])
    mcad_polyhole (d = bolt_size + clearance,
        h = base_thickness + epsilon * 2);

    translate ([0, 0, base_thickness + epsilon])
    mirror (Z)
    mcad_nut_hole (size = bolt_size, tolerance = 0.01);
}
