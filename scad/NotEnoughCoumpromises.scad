
include <ClearMarginBoard.scad>
include <Keyboard.scad>
include <alphanumeric/Case.scad>
include <alphanumeric/CircuitBoard.scad>
include <alphanumeric/RubberFeet.scad>
include <thumb/Case.scad>
include <thumb/CircuitBoard.scad>
include <thumb/RubberFeet.scad>

thumb_case();
thumb_circuit_board();
thumb_rubber_feet();

alphanumeric_case();
alphanumeric_circuit_board();
alphanumeric_rubber_feet();

clear_margin_board();
