
include <../Case.scad>
include <../Keyboard.scad>
include <../PrinterSpec.scad>

// 一番左手前のキーの*中心*の座標
thumb_case_placement_position = [
   max(
      key_pitch.x / 2,
      case_material_min_thickness + printer_min_margin + key_switch_hock_size.x / 2
   ),
   max(
      key_pitch.y / 2,
      case_material_min_thickness + printer_min_margin + key_switch_hock_size.y / 2
   )
];

thumb_case_size = [
   (thumb_case_placement_position.x - key_pitch.x / 2) * 2
      + key_pitch.x * thumb_key_count.x,
   (thumb_case_placement_position.y - key_pitch.y / 2) * 2
      + key_pitch.y * thumb_key_count.y,
   case_thickness
];

thumb_case_inner_space_position = [
   case_material_min_thickness,
   case_material_min_thickness,
   0
];

thumb_case_inner_space_size = [
   thumb_case_size.x - case_material_min_thickness * 2,
   thumb_case_size.y - case_material_min_thickness * 2,
   thumb_case_size.z - case_material_min_thickness
];

module thumb_case(printer_friendly_position = false) {
   if (printer_friendly_position) {
      translate([0, thumb_case_size.y, thumb_case_size.z]) {
         rotate(180, [1, 0, 0]) {
            thumb_case_impl();
         }
      }
   } else {
      thumb_case_impl();
   }
}

module thumb_case_impl() {
   difference() {
      cube(thumb_case_size);

      translate(thumb_case_inner_space_position) {
         cube(thumb_case_inner_space_size);
      }

      for (x = [0 : thumb_key_count.x], y = [0 : thumb_key_count.y]) {
         translate([
            thumb_case_placement_position.x + key_pitch.x * x - key_switch_top_side_size.x / 2,
            thumb_case_placement_position.y + key_pitch.y * y - key_switch_top_side_size.y / 2,
            0
         ]) {
            cube([
               key_switch_top_side_size.x,
               key_switch_top_side_size.y,
               thumb_case_size.z
            ]);
         }
      }
   }
}
