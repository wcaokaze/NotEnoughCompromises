
include <../KeySwitch.scad>
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
            alphanumeric_case_leftfront_key_placement_position.x + key_pitch.x * x,
            alphanumeric_case_leftfront_key_placement_position.y + key_pitch.y * y,
            0
         ]) {
            translate([
               -key_switch_hock_size.x / 2 - printer_min_margin,
               -key_switch_hock_size.y / 2 - printer_min_margin,
               alphanumeric_case_inner_space_size.z - printer_min_margin - key_switch_hock_size.z
            ]) {
               cube([
                  key_switch_hock_size.x + printer_min_margin * 2,
                  key_switch_hock_size.y + printer_min_margin * 2,
                  key_switch_hock_size.z + printer_min_margin
               ]);
            }

            translate([
               -key_switch_bottom_side_size.x / 2 - printer_min_margin,
               -key_switch_bottom_side_size.y / 2 - printer_min_margin,
               0
            ]) {
               cube([
                  key_switch_bottom_side_size.x + printer_min_margin * 2,
                  key_switch_bottom_side_size.y + printer_min_margin * 2,
                  alphanumeric_rubber_feet_size.z
               ]);
            }
         }
      }
   }
}
