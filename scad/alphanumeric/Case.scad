
include <../Case.scad>
include <../Keyboard.scad>
include <../PrinterSpec.scad>

function alphanumeric_case_key_position(x, y) = [
   max(
      key_pitch.x - key_switch_housing_size.x,
      case_material_min_thickness + printer_min_margin
   ) + key_pitch.x * x,
   max(
      key_pitch.y - key_switch_housing_size.y,
      case_material_min_thickness + printer_min_margin
   ) + key_pitch.y * y
];

alphanumeric_case_size = [
   alphanumeric_case_key_position(
      alphanumeric_key_count.x - 1, alphanumeric_key_count.y - 1
   ).x + max(
      key_pitch.x,
      key_switch_housing_size.x + printer_min_margin
         + case_material_min_thickness
   ),
   alphanumeric_case_key_position(
      alphanumeric_key_count.x - 1, alphanumeric_key_count.y - 1
   ).y + max(
      key_pitch.y,
      key_switch_housing_size.y + printer_min_margin
         + case_material_min_thickness
   ),
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

      for (x = [0 : alphanumeric_key_count.x - 1],
           y = [0 : alphanumeric_key_count.y - 1])
      {
         translate([
            alphanumeric_case_key_position(x, y).x + key_switch_top_housing_position.x,
            alphanumeric_case_key_position(x, y).y + key_switch_top_housing_position.y,
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
