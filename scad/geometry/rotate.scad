
function rotate(point, axis, angle) = [
   /* x = */ point.x * (cos(angle) + axis.x * axis.x * (1.0 - cos(angle)))
           + point.y * (axis.x * axis.y * (1.0 - cos(angle)) - axis.z * sin(angle))
           + point.z * (axis.z * axis.x * (1.0 - cos(angle)) + axis.y * sin(angle)),

   /* y = */ point.x * (axis.x * axis.y * (1.0 - cos(angle)) + axis.z * sin(angle))
           + point.y * (cos(angle) + axis.y * axis.y * (1.0 - cos(angle)))
           + point.z * (axis.y * axis.z * (1.0 - cos(angle)) - axis.x * sin(angle)),

   /* z = */ point.x * (axis.z * axis.x * (1.0 - cos(angle)) - axis.y * sin(angle))
           + point.y * (axis.y * axis.z * (1.0 - cos(angle)) + axis.x * sin(angle))
           + point.z * (cos(angle) + axis.z * axis.z * (1.0 - cos(angle)))
];
