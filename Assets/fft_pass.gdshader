shader_type canvas_item;

uniform sampler2D input_texture;
uniform sampler2D butterfly_texture;
uniform int stage;

void fragment() {
    vec2 uv = UV;
    vec2 value = texture(input_texture, uv).rg;

    // For now just return unchanged value for testing
    COLOR = vec4(value, 0.0, 1.0);
}
