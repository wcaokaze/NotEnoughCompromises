
include <KeySwitch.scad>

key_pitch = [16.5, 16.5];

alphanumeric_key_count = [6, 4];
thumb_key_count = [4, 1];

alphanumeric_placement_position = [
   key_pitch.x,
   thumb_key_count.y * key_pitch.y + 10.0
];
