
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
      clear_margin_board_thumb_case_saucer();
      clear_margin_board_thumb_rubber_feet_saucer();
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
