
include <KeySwitch.scad>

key_pitch = [16.5, 16.5];

alphanumeric_key_count = [6, 4];
thumb_key_count = [4, 1];

alphanumeric_placement_position = [
   key_pitch.x,
   thumb_key_count.y * key_pitch.y + 10.0,
   0
];

thumb_placement_position = [0, 0, 0];

microcontroller_size = [33.0, 18.0, 3.6];

microcontroller_position = alphanumeric_placement_position + [
   key_pitch.x * alphanumeric_key_count.x - microcontroller_size.x,
   key_pitch.y * alphanumeric_key_count.y - microcontroller_size.y,
   -microcontroller_size.z
];

tilt_angle = atan2(microcontroller_size.z, microcontroller_position.y);
