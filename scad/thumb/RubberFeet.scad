
include <../KeySwitch.scad>
include <../PrinterSpec.scad>
include <../RubberFeet.scad>
include <Case.scad>
include <CircuitBoard.scad>

thumb_rubber_feet_sheet_size = [
   thumb_circuit_board_size.x,
   thumb_circuit_board_size.y,
   rubber_feet_thickness
];

thumb_rubber_feet_size = [
   thumb_rubber_feet_sheet_size.x,
   thumb_rubber_feet_sheet_size.y,
   thumb_rubber_feet_sheet_size.z
      + thumb_case_inner_space_position.z + thumb_case_inner_space_size.z
      - thumb_circuit_board_position.z
      - printer_min_margin
];

thumb_rubber_feet_position = [
   thumb_circuit_board_position.x,
   thumb_circuit_board_position.y,
   thumb_circuit_board_position.z - rubber_feet_thickness
];

module thumb_rubber_feet() {
   difference() {
      hull() {
         translate(thumb_rubber_feet_position) {
            cube(thumb_rubber_feet_size);
         }

         rotate(-tilt_angle, [1, 0, 0]) {
            translate(thumb_rubber_feet_position) {
               cube(thumb_rubber_feet_sheet_size);
            }
         }
      }

      thumb_rubber_circuit_saucer();
   }
}

module thumb_rubber_circuit_saucer() {
   minkowski() {
      cube([
         0.01,
         0.01,
         thumb_rubber_feet_size.z
      ]);

      thumb_circuit_board(offset = printer_min_margin);
   }
}
