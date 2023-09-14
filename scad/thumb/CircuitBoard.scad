
include <../CircuitBoard.scad>
include <../KeySwitch.scad>
include <Case.scad>

thumb_circuit_board_position = [
   thumb_case_inner_space_position.x + printer_min_margin,
   thumb_case_inner_space_position.y + printer_min_margin + 2.0,
   thumb_case_inner_space_position.z + thumb_case_inner_space_size.z
      - key_switch_hock_size.z - key_switch_bottom_side_size.z
      - circuit_board_thickness
];

thumb_circuit_board_size = [
   thumb_case_inner_space_size.x - printer_min_margin * 2,
   thumb_case_inner_space_size.y - printer_min_margin * 2 - 2.0,
   circuit_board_thickness
];

module thumb_circuit_board() {
   translate(thumb_circuit_board_position) {
      cube(thumb_circuit_board_size);
   }
}
