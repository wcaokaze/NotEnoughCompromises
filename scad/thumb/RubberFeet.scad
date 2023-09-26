
include <../KeySwitch.scad>
include <../PrinterSpec.scad>
include <../RubberFeet.scad>
include <Case.scad>

thumb_rubber_feet_base_size = [
   thumb_case_inner_space_size.x - 2.4,
   thumb_case_inner_space_size.y - 2.4,
   rubber_feet_base_thickness
];

thumb_rubber_feet_base_position = [
   thumb_case_inner_space_position.x + 1.2,
   thumb_case_inner_space_position.y + 1.2,
   thumb_case_inner_space_size.z - thumb_rubber_feet_base_size.z
];

module thumb_rubber_feet() {
   difference() {
      translate(thumb_rubber_feet_base_position) {
         cube(thumb_rubber_feet_base_size);
      }

      for (x = [0 : thumb_key_count.x - 1],
           y = [0 : thumb_key_count.y - 1])
      {
         translate(thumb_case_key_position(x, y)) {
            translate([
               key_switch_hock_position.x - printer_min_margin,
               key_switch_hock_position.y - printer_min_margin,
               thumb_case_inner_space_size.z - printer_min_margin
                  - key_switch_hock_size.z
            ]) {
               cube([
                  key_switch_hock_size.x + printer_min_margin * 2,
                  key_switch_hock_size.y + printer_min_margin * 2,
                  key_switch_hock_size.z + printer_min_margin * 2
               ]);
            }

            translate([
               key_switch_bottom_housing_position.x - printer_min_margin,
               key_switch_bottom_housing_position.y - printer_min_margin,
               -printer_min_margin
            ]) {
               cube([
                  key_switch_bottom_housing_size.x + printer_min_margin * 2,
                  key_switch_bottom_housing_size.y + printer_min_margin * 2,
                  alphanumeric_case_inner_space_size.z + printer_min_margin * 2
               ]);
            }
         }
      }
   }
}
