
include <Case.scad>
include <alphanumeric/Case.scad>
include <thumb/Case.scad>

// alphanumeric_case, thumb_caseが食い込む部分の厚さ
clear_margin_board_top_side_thickness = max(case_thickness - 2.0, 0.0);

// alphanumeric_case, thumb_caseの下側の厚さ
clear_margin_board_bottom_side_thickness = 2.0;

// 周囲にalphanumeric_case, thumb_caseをはみ出させる大きさ
clear_margin_board_padding = 1.0;

clear_margin_board_position = [
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
   cube(clear_margin_board_size);
}
