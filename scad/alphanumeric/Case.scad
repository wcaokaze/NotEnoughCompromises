
include <../Case.scad>
include <../Keyboard.scad>
include <../PrinterSpec.scad>

// 一番左手前のキーの*中心*の座標
alphanumeric_case_leftfront_key_placement_position = [
   max(
      key_pitch.x / 2,
      case_material_min_thickness + printer_min_margin + key_switch_hock_size.x / 2
   ),
   max(
      key_pitch.y / 2,
      case_material_min_thickness + printer_min_margin + key_switch_hock_size.y / 2
   )
];

alphanumeric_case_size = [
   (alphanumeric_case_leftfront_key_placement_position.x - key_pitch.x / 2) * 2
      + key_pitch.x * alphanumeric_key_count.x,
   (alphanumeric_case_leftfront_key_placement_position.y - key_pitch.y / 2) * 2
      + key_pitch.y * alphanumeric_key_count.y,
   case_thickness
];

alphanumeric_case_inner_space_position = [
   case_material_min_thickness,
   case_material_min_thickness,
   0
];

alphanumeric_case_inner_space_size = [
   alphanumeric_case_size.x - case_material_min_thickness * 2,
   alphanumeric_case_size.y - case_material_min_thickness * 2,
   alphanumeric_case_size.z - case_material_min_thickness
];

module alphanumeric_case(printer_friendly_position = false) {
   if (printer_friendly_position) {
      translate([0, alphanumeric_case_size.y, alphanumeric_case_size.z]) {
         rotate(180, [1, 0, 0]) {
            alphanumeric_case_impl();
         }
      }
   } else {
      alphanumeric_case_impl();
   }
}

module alphanumeric_case_impl() {
   difference() {
      cube(alphanumeric_case_size);

      translate(alphanumeric_case_inner_space_position) {
         cube(alphanumeric_case_inner_space_size);
      }

      for (x = [0 : alphanumeric_key_count.x], y = [0 : alphanumeric_key_count.y]) {
         translate([
            alphanumeric_case_leftfront_key_placement_position.x + key_pitch.x * x - key_switch_top_housing_size.x / 2,
            alphanumeric_case_leftfront_key_placement_position.y + key_pitch.y * y - key_switch_top_housing_size.y / 2,
            0
         ]) {
            cube([
               key_switch_top_housing_size.x,
               key_switch_top_housing_size.y,
               alphanumeric_case_size.z
            ]);
         }
      }
   }
}
