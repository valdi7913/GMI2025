shader_type spatial;

void vertex() {
	float freq = 3.0f;
	// Called for every vertex the material is visible on.
	VERTEX.y += 0.5 * (sin(freq * TIME * VERTEX.x * VERTEX.z));
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
