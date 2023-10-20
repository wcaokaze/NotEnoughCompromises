
include <../KeySwitch.scad>
include <../PrinterSpec.scad>
include <../RubberFeet.scad>
include <../geometry/rotate.scad>
include <Case.scad>
include <CircuitBoard.scad>

alphanumeric_rubber_feet_front_cutout_length = 1.5;
alphanumeric_rubber_feet_back_cutout_length  = 0.0;
alphanumeric_rubber_feet_left_cutout_length  = 3.0;
alphanumeric_rubber_feet_right_cutout_length = 3.0;

alphanumeric_rubber_feet_sheet_size = [
   alphanumeric_circuit_board_size.x
      - alphanumeric_rubber_feet_left_cutout_length
      - alphanumeric_rubber_feet_right_cutout_length,
   alphanumeric_circuit_board_size.y
      - alphanumeric_rubber_feet_front_cutout_length
      - alphanumeric_rubber_feet_back_cutout_length,
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
   alphanumeric_circuit_board_position.x + alphanumeric_rubber_feet_left_cutout_length,
   alphanumeric_circuit_board_position.y + alphanumeric_rubber_feet_front_cutout_length,
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

      alphanumeric_rubber_feet_circuit_saucer();
      alphanumeric_rubber_feet_key_switch_hole();
      microcontroller_saucer();
   }
}

module alphanumeric_rubber_feet_circuit_saucer() {
   union() {
      minkowski() {
         cube([
            0.01,
            0.01,
            alphanumeric_rubber_feet_size.z
         ]);

         alphanumeric_circuit_board(offset = printer_min_margin);
      }

      all_indices = [
         for (x = [0 : alphanumeric_key_count.x],
              y = [0 : alphanumeric_key_count.y]) [x, y]
      ];

      peg_saucer_indices = [
         for (idx = all_indices)
         if (search([idx], alphanumeric_rubber_peg_indices)[0] == [])
         idx
      ];

      for (index = peg_saucer_indices) {
         key_position = alphanumeric_case_key_position(index.x, index.y);

         translate([
            alphanumeric_placement_position.x + key_position.x - key_pitch.x / 2,
            alphanumeric_placement_position.y + key_position.y - key_pitch.y / 2,
            alphanumeric_circuit_board_position.z
         ]) {
            cube([key_pitch.x, key_pitch.y, alphanumeric_rubber_feet_size.z]);
         }
      }
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

module alphanumeric_rubber_feet_key_switch_hole() {
   translate(alphanumeric_placement_position
      + [0, 0, alphanumeric_circuit_board_position.z + alphanumeric_circuit_board_size.z])
   {
      for (x = [0 : alphanumeric_key_count.x - 1],
           y = [0 : alphanumeric_key_count.y - 1])
      {
         translate(alphanumeric_case_key_position(x, y)) {
            translate(key_switch_bottom_housing_position
               - [printer_min_margin, printer_min_margin, printer_min_margin])
            {
               cube(key_switch_bottom_housing_size
                  + [printer_min_margin * 2, printer_min_margin * 2, printer_min_margin * 2]);
            }

            translate(key_switch_hock_position
               - [printer_min_margin, printer_min_margin, printer_min_margin])
            {
               cube(key_switch_hock_size
                  + [printer_min_margin * 2, printer_min_margin * 2, printer_min_margin * 2]);
            }

            translate(key_switch_top_housing_position
               - [printer_min_margin, printer_min_margin, printer_min_margin])
            {
               cube(key_switch_top_housing_size
                  + [printer_min_margin * 2, printer_min_margin * 2, printer_min_margin * 2]);
            }
         }
      }
   }
}
