
include <../KeySwitch.scad>
include <../PrinterSpec.scad>
include <../RubberFeet.scad>
include <../geometry/rotate.scad>
include <Case.scad>
include <CircuitBoard.scad>

alphanumeric_rubber_feet_sheet_size = [
   alphanumeric_circuit_board_size.x,
   alphanumeric_circuit_board_size.y,
   rubber_feet_thickness
];

alphanumeric_rubber_feet_size = [
   alphanumeric_rubber_feet_sheet_size.x,
   alphanumeric_rubber_feet_sheet_size.y,
   alphanumeric_rubber_feet_sheet_size.z
      + alphanumeric_case_inner_space_position.z
      + alphanumeric_case_inner_space_size.z
      - alphanumeric_circuit_board_position.z
      - printer_min_margin
];

alphanumeric_rubber_feet_position = [
   alphanumeric_circuit_board_position.x,
   alphanumeric_circuit_board_position.y,
   alphanumeric_circuit_board_position.z - rubber_feet_thickness
];

module alphanumeric_rubber_feet() {
   difference() {
      hull() {
         translate(alphanumeric_placement_position + alphanumeric_rubber_feet_position) {
            cube(alphanumeric_rubber_feet_size);
         }

         rotate(-tilt_angle, [1, 0, 0]) {
            translate(alphanumeric_placement_position + alphanumeric_rubber_feet_position) {
               cube(alphanumeric_rubber_feet_sheet_size);
            }
         }
      }

      alphanumeric_rubber_circuit_saucer();
      microcontroller_saucer();
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

module microcontroller_saucer() {
   front_position = [
      microcontroller_position.x - printer_min_margin,
      microcontroller_position.y - printer_min_margin,
      alphanumeric_placement_position.z
         + alphanumeric_rubber_feet_position.z - printer_min_margin
   ];

   back_position = alphanumeric_placement_position
      + alphanumeric_rubber_feet_position + alphanumeric_rubber_feet_size
      + [printer_min_margin, printer_min_margin, printer_min_margin];

   z = rotate(
      [back_position.x, back_position.y, front_position.z],
      [1, 0, 0],
      -tilt_angle
   ).z;

   translate([front_position.x, front_position.y, z]) {
      cube([
         back_position.x - front_position.x,
         back_position.y - front_position.y,
         back_position.z - z
      ]);
   }
}
