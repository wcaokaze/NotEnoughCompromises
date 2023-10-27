
include <../KeySwitch.scad>
include <../PrinterSpec.scad>
include <../RubberFeet.scad>
include <Case.scad>
include <CircuitBoard.scad>

thumb_rubber_feet_front_cutout_length = 1.5;
thumb_rubber_feet_back_cutout_length  = 0.0;
thumb_rubber_feet_left_cutout_length  = 3.0;
thumb_rubber_feet_right_cutout_length = 3.0;

thumb_rubber_feet_sheet_size = [
   thumb_circuit_board_size.x
      - thumb_rubber_feet_left_cutout_length
      - thumb_rubber_feet_right_cutout_length,
   thumb_circuit_board_size.y
      - thumb_rubber_feet_front_cutout_length
      - thumb_rubber_feet_back_cutout_length,
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
   thumb_circuit_board_position.x + thumb_rubber_feet_left_cutout_length,
   thumb_circuit_board_position.y + thumb_rubber_feet_front_cutout_length,
   thumb_circuit_board_position.z - rubber_feet_thickness
];

module thumb_rubber_feet(printer_friendly_position = false) {
   if (printer_friendly_position) {
      p = thumb_placement_position + thumb_rubber_feet_position;

      rotate(tilt_angle, [1, 0, 0]) {
         translate(-rotate(p, [1, 0, 0], -tilt_angle)) {
            thumb_rubber_feet_impl();
         }
      }
   } else {
      thumb_rubber_feet_impl();
   }
}

module thumb_rubber_feet_impl() {
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

      thumb_rubber_feet_circuit_saucer();
      thumb_rubber_feet_key_switch_hole();
      thumb_rubber_feet_clear_margin_board_hole();
   }
}

module thumb_rubber_feet_circuit_saucer() {
   union() {
      minkowski() {
         cube([
            0.01,
            0.01,
            thumb_rubber_feet_size.z
         ]);

         thumb_circuit_board(offset = printer_min_margin);
      }

      all_indices = [
         for (x = [0 : thumb_key_count.x],
              y = [0 : thumb_key_count.y]) [x, y]
      ];

      peg_saucer_indices = [
         for (idx = all_indices)
         if (search([idx], thumb_rubber_peg_indices)[0] == [])
         idx
      ];

      for (index = peg_saucer_indices) {
         key_position = thumb_case_key_position(index.x, index.y);

         translate([
            thumb_placement_position.x + key_position.x - key_pitch.x / 2,
            thumb_placement_position.y + key_position.y - key_pitch.y / 2,
            thumb_circuit_board_position.z
         ]) {
            cube([key_pitch.x, key_pitch.y, thumb_rubber_feet_size.z]);
         }
      }
   }
}

module thumb_rubber_feet_key_switch_hole() {
   translate(thumb_placement_position
      + [0, 0, thumb_circuit_board_position.z + thumb_circuit_board_size.z])
   {
      for (x = [0 : thumb_key_count.x - 1],
           y = [0 : thumb_key_count.y - 1])
      {
         translate(thumb_case_key_position(x, y)) {
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

module thumb_rubber_feet_clear_margin_board_hole() {
   front = rotate(
      [
         0,
         thumb_placement_position.y + thumb_rubber_feet_position.y,
         thumb_rubber_feet_position.z
      ],
      [1, 0, 0],
      -tilt_angle
   ).y;

   bottom = rotate(
      [
         0,
         thumb_placement_position.y + thumb_rubber_feet_position.y
            + thumb_rubber_feet_size.y,
         thumb_rubber_feet_position.z
      ],
      [1, 0, 0],
      -tilt_angle
   ).z;

   back = thumb_placement_position.y + thumb_rubber_feet_position.y + thumb_rubber_feet_size.y;
   top  = thumb_placement_position.z + thumb_rubber_feet_position.z + thumb_rubber_feet_size.z;

   difference() {
      intersection() {
         translate([
            thumb_placement_position.x + thumb_rubber_feet_position.x
               - printer_min_margin,
            front - printer_min_margin,
            bottom - printer_min_margin
         ]) {
            cube([
               thumb_rubber_feet_size.x + printer_min_margin * 2,
               back - front + printer_min_margin * 2,
               top - bottom + printer_min_margin * 2
            ]);
         }

         for (index = clear_margin_board_thumb_peg_indices) {
            key_position = thumb_case_key_position(index.x, index.y);

            translate([
               thumb_placement_position.x + key_position.x - key_pitch.x / 2,
               thumb_placement_position.y + key_position.y - key_pitch.y / 2,
               bottom - printer_min_margin * 2
            ]) {
               cube([key_pitch.x, key_pitch.y, top - bottom + printer_min_margin * 4]);
            }
         }
      }

      translate([0, 0, bottom - printer_min_margin * 2]) {
         minkowski() {
            cube([0.01, 0.01, top - bottom + printer_min_margin * 4]);

            translate([0, 0, -thumb_circuit_board_position.z]) {
               thumb_circuit_board(offset = - printer_min_margin);
            }
         }
      }
   }
}
