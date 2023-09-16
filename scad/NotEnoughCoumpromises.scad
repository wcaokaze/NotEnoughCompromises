
include <Keyboard.scad>
include <alphanumeric/Case.scad>
include <alphanumeric/CircuitBoard.scad>
include <alphanumeric/RubberFeet.scad>
include <thumb/Case.scad>
include <thumb/CircuitBoard.scad>

thumb_case();
thumb_circuit_board();

translate(alphanumeric_placement_position) {
   alphanumeric_case();
   alphanumeric_circuit_board();
   alphanumeric_rubber_feet();
}
