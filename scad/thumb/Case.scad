
include <../Case.scad>
include <../Keyboard.scad>
include <../PrinterSpec.scad>

function thumb_case_key_position(x, y) = [
   max(
      key_pitch.x - key_switch_housing_size.x,
      case_material_min_thickness + printer_min_margin
   ) + key_pitch.x * x,
   max(
      key_pitch.y - key_switch_housing_size.y,
      case_material_min_thickness + printer_min_margin
   ) + key_pitch.y * y
];

thumb_case_size = [
   thumb_case_key_position(
      thumb_key_count.x - 1, thumb_key_count.y - 1
   ).x + max(
      key_pitch.x,
      key_switch_housing_size.x + printer_min_margin
         + case_material_min_thickness
   ),
   thumb_case_key_position(
      thumb_key_count.x - 1, thumb_key_count.y - 1
   ).y + max(
      key_pitch.y,
      key_switch_housing_size.y + printer_min_margin
         + case_material_min_thickness
   ),
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

      for (x = [0 : thumb_key_count.x - 1],
           y = [0 : thumb_key_count.y - 1])
      {
         translate([
            thumb_case_key_position(x, y).x + key_switch_top_housing_position.x,
            thumb_case_key_position(x, y).y + key_switch_top_housing_position.y,
            0
         ]) {
            cube([
               key_switch_top_housing_size.x,
               key_switch_top_housing_size.y,
               thumb_case_size.z
            ]);
         }
      }
   }
}
