
include <../PrinterSpec.scad>
include <../RubberFeet.scad>
include <Case.scad>

alphanumeric_rubber_feet_position = [
   alphanumeric_case_inner_space_position.x + 1.0,
   alphanumeric_case_inner_space_position.y + 1.0,
   0
];

alphanumeric_rubber_feet_size = [
   alphanumeric_case_inner_space_size.x - 2.0,
   alphanumeric_case_inner_space_size.y - 2.0,
   alphanumeric_case_inner_space_size.z
];

module alphanumeric_rubber_feet() {
   difference() {
      translate(alphanumeric_rubber_feet_position) {
         cube(alphanumeric_rubber_feet_size);
      }

      for (x = [0 : alphanumeric_key_count.x], y = [0 : alphanumeric_key_count.y]) {
         translate([
            alphanumeric_case_placement_position.x + key_pitch.x * x - key_switch_top_side_size.x / 2,
            alphanumeric_case_placement_position.y + key_pitch.y * y - key_switch_top_side_size.y / 2,
            0
         ]) {
            cube([
               key_switch_top_side_size.x,
               key_switch_top_side_size.y,
               alphanumeric_rubber_feet_size.z
            ]);
         }
      }
   }
}
