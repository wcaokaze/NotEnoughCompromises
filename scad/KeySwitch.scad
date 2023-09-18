
// hock - Chocスイッチの周囲のちょっと出っ張ってる部分
key_switch_hock_size = [15.0, 15.0, 0.8];

// top_side - Chocスイッチのトップハウジング
key_switch_top_housing_size = [13.8, 13.8, 3.3];

// bottom_side - Chocスイッチのボトムハウジング。ただしhock部は含まない
key_switch_bottom_housing_size = [14.5, 13.8, 2.2];

// Chocスイッチのハウジング部全体の大きさ。こちらはhockを含む
key_switch_housing_size = [
   key_switch_hock_size.x,
   key_switch_hock_size.y,
   key_switch_bottom_housing_size.z + key_switch_hock_size.z
      + key_switch_top_housing_size.z
];

key_switch_hock_position = [0, 0, key_switch_bottom_housing_size.z];

key_switch_bottom_housing_position = [
   (key_switch_housing_size.x - key_switch_bottom_housing_size.x) / 2,
   (key_switch_housing_size.y - key_switch_bottom_housing_size.y) / 2,
   0
];

key_switch_top_housing_position = [
   (key_switch_housing_size.x - key_switch_top_housing_size.x) / 2,
   (key_switch_housing_size.y - key_switch_top_housing_size.y) / 2,
   key_switch_bottom_housing_size.z + key_switch_hock_size.z
];
