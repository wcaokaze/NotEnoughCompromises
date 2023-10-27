
include <CircuitBoard.scad>
include <KeySwitch.scad>

case_material_min_thickness = 1.0;

case_thickness = circuit_board_thickness
   + key_switch_bottom_housing_size.z + key_switch_hock_size.z
   + case_material_min_thickness - 1.0;
