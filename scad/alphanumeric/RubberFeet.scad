
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

      for (x = [0 : alphanumeric_key_count.x - 1],
           y = [0 : alphanumeric_key_count.y - 1])
      {
         translate(alphanumeric_case_key_position(x, y)) {
            translate([
               key_switch_hock_position.x - printer_min_margin,
               key_switch_hock_position.y - printer_min_margin,
               alphanumeric_case_inner_space_size.z - printer_min_margin
                  - key_switch_hock_size.z
            ]) {
               cube([
                  key_switch_hock_size.x + printer_min_margin * 2,
                  key_switch_hock_size.y + printer_min_margin * 2,
                  key_switch_hock_size.z + printer_min_margin
               ]);
            }

            translate([
               key_switch_bottom_housing_position.x - printer_min_margin,
               key_switch_bottom_housing_position.y - printer_min_margin,
               0
            ]) {
               cube([
                  key_switch_bottom_housing_size.x + printer_min_margin * 2,
                  key_switch_bottom_housing_size.y + printer_min_margin * 2,
                  alphanumeric_rubber_feet_size.z
               ]);
            }
         }
      }
   }
}
