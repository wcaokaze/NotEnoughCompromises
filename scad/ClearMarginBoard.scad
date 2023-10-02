
include <Case.scad>
include <Keyboard.scad>
include <RubberFeet.scad>
include <alphanumeric/Case.scad>
include <alphanumeric/RubberFeet.scad>
include <thumb/Case.scad>
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
      translate(clear_margin_board_position) {
         cube(clear_margin_board_size);
      }
      clear_margin_board_alphanumeric_case_saucer();
      clear_margin_board_alphanumeric_rubber_feet_saucer();
      clear_margin_board_alphanumeric_circuit_saucer();
      clear_margin_board_alphanumeric_key_switch_hole();
      clear_margin_board_thumb_case_saucer();
      clear_margin_board_thumb_rubber_feet_saucer();
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
            cube(alphanumeric_case_inner_space_size + [0, 0, printer_min_margin]);
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
   translate([
      alphanumeric_placement_position.x,
      alphanumeric_placement_position.y,
      alphanumeric_placement_position.z
         + alphanumeric_circuit_board_position.z + alphanumeric_circuit_board_size.z
   ]) {
      for (x = [0 : alphanumeric_key_count.x - 1],
           y = [0 : alphanumeric_key_count.y - 1])
      {
         translate(alphanumeric_case_key_position(x, y)) {
            translate([
               key_switch_bottom_housing_position.x - printer_min_margin,
               key_switch_bottom_housing_position.y - printer_min_margin,
               -printer_min_margin
            ]) {
               cube(key_switch_bottom_housing_size
                  + [printer_min_margin * 2, printer_min_margin * 2 ,printer_min_margin * 2]);
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
            cube(thumb_case_inner_space_size + [0, 0, printer_min_margin]);
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
   translate([
      thumb_placement_position.x,
      thumb_placement_position.y,
      thumb_placement_position.z
         + thumb_circuit_board_position.z + thumb_circuit_board_size.z
   ]) {
      for (x = [0 : thumb_key_count.x - 1],
           y = [0 : thumb_key_count.y - 1])
      {
         translate(thumb_case_key_position(x, y)) {
            translate([
               key_switch_bottom_housing_position.x - printer_min_margin,
               key_switch_bottom_housing_position.y - printer_min_margin,
               -printer_min_margin
            ]) {
               cube(key_switch_bottom_housing_size
                  + [printer_min_margin * 2, printer_min_margin * 2 ,printer_min_margin * 2]);
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
