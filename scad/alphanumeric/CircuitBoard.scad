
include <../CircuitBoard.scad>
include <../Keyboard.scad>
include <../KeySwitch.scad>
include <Case.scad>

alphanumeric_circuit_front_cutout_length = 2.0;
alphanumeric_circuit_left_cutout_length  = 1.2;

alphanumeric_circuit_board_position = [
   alphanumeric_case_inner_space_position.x + printer_min_margin
      + alphanumeric_circuit_left_cutout_length,
   alphanumeric_case_inner_space_position.y + printer_min_margin
      + alphanumeric_circuit_front_cutout_length,
   alphanumeric_case_inner_space_position.z + alphanumeric_case_inner_space_size.z
      - key_switch_hock_size.z - key_switch_bottom_housing_size.z
      - circuit_board_thickness
];

alphanumeric_circuit_board_size = [
   alphanumeric_case_inner_space_size.x - printer_min_margin * 2
      - alphanumeric_circuit_left_cutout_length,
   alphanumeric_case_inner_space_size.y - printer_min_margin * 2
      - alphanumeric_circuit_front_cutout_length,
   circuit_board_thickness
];

module alphanumeric_circuit_board() {
   intersection() {
      translate(alphanumeric_circuit_board_position) {
         cube(alphanumeric_circuit_board_size);
      }

      for (x = [0 : alphanumeric_key_count.x - 1],
           y = [0 : alphanumeric_key_count.y - 1])
      {
         translate(alphanumeric_case_key_position(x, y)) {
            translate([
               key_switch_bottom_housing_position.x - printer_min_margin,
               key_switch_bottom_housing_position.y - printer_min_margin,
               alphanumeric_circuit_board_position.z - printer_min_margin
            ]) {
               cube([
                  key_switch_bottom_housing_size.x + printer_min_margin * 2,
                  key_switch_bottom_housing_size.y + printer_min_margin * 2,
                  alphanumeric_circuit_board_size.z + printer_min_margin * 2
               ]);
            }
         }
      }
   }
}
