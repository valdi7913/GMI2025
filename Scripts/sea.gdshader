shader_type spatial;
uniform float frequency : hint_range(0, 1, 0.01);
uniform float amplitude : hint_range(0, 1, 0.01);
uniform float ambient : hint_range(0, 1, 0.01);
uniform int sineN : hint_range(0,10,1);

void vertex() {
	
	// Called for every vertex the material is visible on.
	for(int i = 1; i < sineN + 1; i++) {
		float divisor = float(i);
		VERTEX.y += amplitude * sin(frequency/divisor * TIME * VERTEX.x * VERTEX.z);
	}
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = vec3(.1,.1,1.0);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
