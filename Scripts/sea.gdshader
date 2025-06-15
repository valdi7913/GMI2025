shader_type spatial;

// Uniforms for lighting
uniform vec3 light_direction  = vec3(0.0, -1.0 , -1.0);
uniform vec3 light_color: source_color = vec3(1.0, 1.0, 1.0);

uniform vec3 ambient_color: source_color = vec3(0.1, 0.1, 0.1);
uniform vec3 diffuse_color: source_color = vec3(0.8, 0.5, 0.2);
uniform vec3 specular_color: source_color = vec3(1.0);
uniform float shininess: hint_range(0, 100, 1) = 32.0;

// Uniforms for sine wave generation
uniform int sineN : hint_range(1,10,1) = 4;
uniform float frequency : hint_range(0, 1, 0.01) = 0.1;
uniform float amplitude : hint_range(0, 1, 0.01) = 0.2;
uniform float speed : hint_range(1.0, 100.0, 1.0) =10;

void vertex() {
	for(int i = 1; i <= sineN; i++) {
		float wave1 = sin(frequency * VERTEX.x + TIME * speed) * amplitude;
		float wave2 = sin(frequency * VERTEX.z + TIME * speed) * amplitude;
		VERTEX.y += wave1 + wave2;
	}
}

void fragment() {
	// Normalize vectors
	vec3 N = normalize(NORMAL);
	vec3 L = normalize(-light_direction); // Light coming *from* the direction
	vec3 V = normalize(-VIEW); // View direction
	vec3 H = normalize(L + V); // Halfway vector

	// Lighting terms
	float NdotL = max(dot(N, L), 0.0);
	float NdotH = max(dot(N, H), 0.0);

	vec3 ambient = ambient_color;
	vec3 diffuse = diffuse_color * NdotL;
	vec3 specular = specular_color * pow(NdotH, shininess);

	ALBEDO = ambient + diffuse + specular;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
