
include <../Case.scad>
include <../Keyboard.scad>

module thumb_case() {
   cube([
      key_pitch.x * thumb_key_count.x,
      key_pitch.y * thumb_key_count.y,
      case_thickness
   ]);
}
