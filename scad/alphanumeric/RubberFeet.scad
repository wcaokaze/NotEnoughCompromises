
include <../KeySwitch.scad>
include <../PrinterSpec.scad>
include <../RubberFeet.scad>
include <Case.scad>
include <CircuitBoard.scad>

alphanumeric_rubber_feet_size = [
   alphanumeric_circuit_board_size.x,
   alphanumeric_circuit_board_size.y,
   alphanumeric_case_inner_space_position.z + alphanumeric_case_inner_space_size.z
      - alphanumeric_circuit_board_position.z + rubber_feet_thickness
      - printer_min_margin
];

alphanumeric_rubber_feet_position = [
   alphanumeric_circuit_board_position.x,
   alphanumeric_circuit_board_position.y,
   alphanumeric_circuit_board_position.z - rubber_feet_thickness
];

module alphanumeric_rubber_feet() {
   difference() {
      translate(alphanumeric_rubber_feet_position) {
         cube(alphanumeric_rubber_feet_size);
      }
      alphanumeric_rubber_circuit_saucer();
   }
}

module alphanumeric_rubber_circuit_saucer() {
   minkowski() {
      cube([
         0.01,
         0.01,
         alphanumeric_rubber_feet_size.z
      ]);

      alphanumeric_circuit_board(offset = printer_min_margin);
   }
}
