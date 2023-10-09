
include <Case.scad>
include <Keyboard.scad>
include <RubberFeet.scad>
include <alphanumeric/Case.scad>
include <alphanumeric/CircuitBoard.scad>
include <alphanumeric/RubberFeet.scad>
include <thumb/Case.scad>
include <thumb/CircuitBoard.scad>
include <thumb/RubberFeet.scad>

// alphanumeric_case, thumb_caseが食い込む部分の厚さ
clear_margin_board_top_side_thickness = max(case_thickness - 2.0, 0.0);

// alphanumeric_case, thumb_caseの下側の厚さ
clear_margin_board_bottom_side_thickness = 2.0;

// 周囲にalphanumeric_case, thumb_caseをはみ出させる大きさ
clear_margin_board_padding = 1.0;

clear_margin_board_position = thumb_placement_position + [
   clear_margin_board_padding,
   clear_margin_board_padding,
   -clear_margin_board_bottom_side_thickness
];

clear_margin_board_size = [
   alphanumeric_placement_position.x + alphanumeric_case_size.x
      - clear_margin_board_padding * 2,
   alphanumeric_placement_position.y + alphanumeric_case_size.y
      - clear_margin_board_padding * 2,
   clear_margin_board_top_side_thickness + clear_margin_board_bottom_side_thickness
];

module clear_margin_board() {
   difference() {
      union() {
         difference() {
            translate(clear_margin_board_position) {
               cube(clear_margin_board_size);
            }

            translate(
               alphanumeric_placement_position + [
                  printer_min_margin,
                  printer_min_margin,
                  clear_margin_board_position.z - printer_min_margin
               ]
            ) {
               cube([
                  alphanumeric_case_inner_space_position.x
                     + alphanumeric_case_inner_space_size.x + printer_min_margin * 2,
                  alphanumeric_case_inner_space_position.y
                     + alphanumeric_case_inner_space_size.y + printer_min_margin * 2,
                  clear_margin_board_size.z + printer_min_margin * 2
               ]);
            }

            translate(
               thumb_placement_position + [
                  -printer_min_margin,
                  -printer_min_margin,
                  clear_margin_board_position.z - printer_min_margin
               ]
            ) {
               cube([
                  thumb_case_inner_space_position.x
                        + thumb_case_inner_space_size.x + printer_min_margin,
                  thumb_case_inner_space_position.y
                        + thumb_case_inner_space_size.y + printer_min_margin,
                  clear_margin_board_size.z + printer_min_margin * 2
               ]);
            }
         }

         alphanumeric_left_front_point = [
            alphanumeric_placement_position.x,
            alphanumeric_placement_position.y,
            clear_margin_board_position.z
         ];
         alphanumeric_right_back_point = [
            min(
               alphanumeric_placement_position.x
                  + alphanumeric_circuit_board_position.x
                  + alphanumeric_circuit_board_size.x,
               alphanumeric_placement_position.x
                  + alphanumeric_case_key_position(
                     alphanumeric_key_count.x - 1, alphanumeric_key_count.y - 1
                  ).x
                  + key_switch_bottom_housing_position.x
                  + key_switch_bottom_housing_size.x
            ),
            min(
               alphanumeric_placement_position.y
                  + alphanumeric_circuit_board_position.y
                  + alphanumeric_circuit_board_size.y,
               alphanumeric_placement_position.y
                  + alphanumeric_case_key_position(
                     alphanumeric_key_count.x - 1, alphanumeric_key_count.y - 1
                  ).y
                  + key_switch_bottom_housing_position.y
                  + key_switch_bottom_housing_size.y
            ),
            alphanumeric_placement_position.z
               + alphanumeric_case_inner_space_position.z
               + alphanumeric_case_inner_space_size.z
         ];

         translate(alphanumeric_left_front_point) {
            cube(alphanumeric_right_back_point - alphanumeric_left_front_point
               - [printer_min_margin, printer_min_margin, printer_min_margin]);
         }

         thumb_left_front_point = [
            max(
               thumb_placement_position.x + thumb_circuit_board_position.x,
               thumb_placement_position.x
                  + thumb_case_key_position(0, 0).x
                  + key_switch_bottom_housing_position.x
            ),
            max(
               thumb_placement_position.y + thumb_circuit_board_position.y,
               thumb_placement_position.y
                  + thumb_case_key_position(0, 0).y
                  + key_switch_bottom_housing_position.y
            ),
            clear_margin_board_position.z
         ];
         thumb_right_back_point = [
            thumb_placement_position.x + thumb_case_size.x,
            thumb_placement_position.y + thumb_case_size.y,
            thumb_placement_position.z
               + thumb_case_inner_space_position.z
               + thumb_case_inner_space_size.z
         ];

         translate(thumb_left_front_point
            + [printer_min_margin, printer_min_margin, printer_min_margin]
         ) {
            cube(thumb_right_back_point - thumb_left_front_point
               - [printer_min_margin, printer_min_margin, printer_min_margin]);
         }
      }

      clear_margin_board_alphanumeric_case_saucer();
      //clear_margin_board_alphanumeric_rubber_feet_saucer();
      clear_margin_board_alphanumeric_circuit_saucer();
      clear_margin_board_alphanumeric_key_switch_hole();
      clear_margin_board_thumb_case_saucer();
      //clear_margin_board_thumb_rubber_feet_saucer();
      clear_margin_board_thumb_circuit_saucer();
      clear_margin_board_thumb_key_switch_hole();
   }
}

module clear_margin_board_alphanumeric_case_saucer() {
   translate(alphanumeric_placement_position + [0, 0, -printer_min_margin]) {
      difference() {
         cube(alphanumeric_case_size + [0, 0, printer_min_margin]);

         translate(alphanumeric_case_inner_space_position
            + [printer_min_margin, printer_min_margin, -printer_min_margin])
         {
            cube(alphanumeric_case_inner_space_size
               + [-printer_min_margin * 2, -printer_min_margin * 2, printer_min_margin]);
         }
      }
   }
}

module clear_margin_board_alphanumeric_rubber_feet_saucer() {
   translate([
      alphanumeric_placement_position.x,
      alphanumeric_placement_position.y,
      alphanumeric_rubber_feet_base_position.z
   ]) {
      cube(alphanumeric_case_size);
   }
}

module clear_margin_board_alphanumeric_circuit_saucer() {
   translate([
      alphanumeric_placement_position.x,
      alphanumeric_placement_position.y,
      clear_margin_board_position.z - printer_min_margin
   ]) {
      minkowski() {
         cube([
            0.01,
            0.01,
            alphanumeric_circuit_board_position.z
               + alphanumeric_circuit_board_size.z
               - clear_margin_board_position.z + printer_min_margin * 2
         ]);

         alphanumeric_circuit_board(offset = printer_min_margin);
      }
   }
}

module clear_margin_board_alphanumeric_key_switch_hole() {
   translate(alphanumeric_placement_position
      + [0, 0, alphanumeric_circuit_board_position.z + alphanumeric_circuit_board_size.z])
   {
      difference() {
         left_front_point
            = alphanumeric_case_key_position(0, 0)
            + key_switch_hock_position;

         right_back_point
            = alphanumeric_case_key_position(
               alphanumeric_key_count.x - 1, alphanumeric_key_count.y - 1
            )
            + key_switch_hock_position
            + key_switch_hock_size;

         z = key_switch_hock_position.z - printer_min_margin;
         h = key_switch_hock_size.z + printer_min_margin;

         translate([0, 0, z]) {
            cube([alphanumeric_case_size.x, alphanumeric_case_size.y, h]);
         }

         translate([left_front_point.x, left_front_point.y, z - printer_min_margin]) {
            cube([
               right_back_point.x - left_front_point.x - printer_min_margin * 2,
               right_back_point.y - left_front_point.y - printer_min_margin * 2,
               h + printer_min_margin * 2
            ]);
         }
      }

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

module clear_margin_board_thumb_case_saucer() {
   translate(thumb_placement_position + [0, 0, -printer_min_margin]) {
      difference() {
         cube(thumb_case_size + [0, 0, printer_min_margin]);

         translate(thumb_case_inner_space_position
            + [printer_min_margin, printer_min_margin, -printer_min_margin])
         {
            cube(thumb_case_inner_space_size
               + [-printer_min_margin * 2, -printer_min_margin * 2, printer_min_margin]);
         }
      }
   }
}

module clear_margin_board_thumb_rubber_feet_saucer() {
   translate([
      thumb_placement_position.x,
      thumb_placement_position.y,
      thumb_rubber_feet_base_position.z
   ]) {
      cube(thumb_case_size);
   }
}

module clear_margin_board_thumb_key_switch_hole() {
   translate(thumb_placement_position
      + [0, 0, thumb_circuit_board_position.z + thumb_circuit_board_size.z])
   {
      difference() {
         left_front_point
            = thumb_case_key_position(0, 0)
            + key_switch_hock_position;

         right_back_point
            = thumb_case_key_position(
               thumb_key_count.x - 1, thumb_key_count.y - 1
            )
            + key_switch_hock_position
            + key_switch_hock_size;

         z = key_switch_hock_position.z - printer_min_margin;
         h = key_switch_hock_size.z + printer_min_margin;

         translate([0, 0, z]) {
            cube([thumb_case_size.x, thumb_case_size.y, h]);
         }

         translate([left_front_point.x, left_front_point.y, z - printer_min_margin]) {
            cube([
               right_back_point.x - left_front_point.x - printer_min_margin * 2,
               right_back_point.y - left_front_point.y - printer_min_margin * 2,
               h + printer_min_margin * 2
            ]);
         }
      }

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

module clear_margin_board_thumb_circuit_saucer() {
   translate([
      thumb_placement_position.x,
      thumb_placement_position.y,
      clear_margin_board_position.z - printer_min_margin
   ]) {
      minkowski() {
         cube([
            0.01,
            0.01,
            thumb_circuit_board_position.z + thumb_circuit_board_size.z
               - clear_margin_board_position.z + printer_min_margin * 2
         ]);

         thumb_circuit_board(offset = printer_min_margin);
      }
   }
}
