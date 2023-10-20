
include <KeySwitch.scad>

key_pitch = [16.5, 16.5];

alphanumeric_key_count = [6, 4];
thumb_key_count = [4, 1];

alphanumeric_rubber_peg_indices = [
                   [2, 3], [3, 3],
           [1, 2], [2, 2], [3, 2], [4, 2], [5, 2],
                   [2, 1],         [4, 1]

];

clear_margin_board_alphanumeric_peg_indices = [
   [0, 3], [1, 3],

   [0, 1], [1, 1],         [3, 1],         [5, 1],
           [1, 0],         [3, 0],         [5, 0]
];

thumb_rubber_peg_indices = [
           [1, 1],         [3, 1],
           [1, 0],         [3, 0]
];

clear_margin_board_thumb_peg_indices = [
                   [2, 1],
                   [2, 0]
];

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
