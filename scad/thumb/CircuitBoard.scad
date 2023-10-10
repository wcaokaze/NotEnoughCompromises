
include <../CircuitBoard.scad>
include <../Keyboard.scad>
include <../KeySwitch.scad>
include <Case.scad>

thumb_circuit_board_front_cutout_length = 2.0;
thumb_circuit_board_back_cutout_length  = 1.2;
thumb_circuit_board_left_cutout_length  = 1.2;
thumb_circuit_board_right_cutout_length = 1.2;

// 各キースイッチの基板同士の間をつなぐ基板の幅
thumb_circuit_board_bridge_width = 5.0;

thumb_circuit_board_position = [
   thumb_case_inner_space_position.x + printer_min_margin
      + thumb_circuit_board_left_cutout_length,
   thumb_case_inner_space_position.y + printer_min_margin
      + thumb_circuit_board_front_cutout_length,
   thumb_case_inner_space_position.z + thumb_case_inner_space_size.z
      - key_switch_hock_size.z - key_switch_bottom_housing_size.z
      - circuit_board_thickness
];

thumb_circuit_board_size = [
   thumb_case_inner_space_size.x - printer_min_margin * 2
      - thumb_circuit_board_left_cutout_length - thumb_circuit_board_right_cutout_length,
   thumb_case_inner_space_size.y - printer_min_margin * 2
      - thumb_circuit_board_front_cutout_length - thumb_circuit_board_back_cutout_length,
   circuit_board_thickness
];

module thumb_circuit_board(offset = 0.0) {
   intersection() {
      translate(thumb_circuit_board_position - [offset, offset, 0]) {
         cube(thumb_circuit_board_size + [offset * 2, offset * 2, 0]);
      }

      for (x = [0 : thumb_key_count.x - 1],
           y = [0 : thumb_key_count.y - 1])
      {
         translate(thumb_case_key_position(x, y)) {
            translate([
               key_switch_bottom_housing_position.x - printer_min_margin - offset,
               key_switch_bottom_housing_position.y - printer_min_margin - offset,
               thumb_circuit_board_position.z - printer_min_margin
            ]) {
               cube([
                  key_switch_bottom_housing_size.x + printer_min_margin * 2 + offset * 2,
                  key_switch_bottom_housing_size.y + printer_min_margin * 2 + offset * 2,
                  thumb_circuit_board_size.z + printer_min_margin * 2
               ]);
            }

            if (x >= 1) {
               thumb_circuit_board_horizontal_bridge(offset);
            }
            if (y >= 1) {
               thumb_circuit_board_vertical_bridge(offset);
            }
         }
      }
   }
}

module thumb_circuit_board_horizontal_bridge(offset = 0.0) {
   translate([
      key_switch_housing_size.x / 2 - key_pitch.x,
      key_switch_housing_size.y / 2 - thumb_circuit_board_bridge_width / 2 - offset,
      thumb_circuit_board_position.z - printer_min_margin
   ]) {
      cube([
         key_pitch.x,
         thumb_circuit_board_bridge_width + offset * 2,
         thumb_circuit_board_size.z + printer_min_margin * 2
      ]);
   }
}

module thumb_circuit_board_vertical_bridge(offset = 0.0) {
   translate([
      key_switch_housing_size.x / 2 - thumb_circuit_board_bridge_width / 2 - offset,
      key_switch_housing_size.y / 2 - key_pitch.y,
      thumb_circuit_board_position.z - printer_min_margin
   ]) {
      cube([
         thumb_circuit_board_bridge_width + offset * 2,
         key_pitch.y,
         thumb_circuit_board_size.z + printer_min_margin * 2
      ]);
   }
}
