
include <KeySwitch.scad>

rubber_feet_material_min_thickness = 1.0;

rubber_feet_base_thickness = max(
   key_switch_hock_size.z + key_switch_bottom_housing_size.z / 2,
   rubber_feet_material_min_thickness
);
