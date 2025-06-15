shader_type canvas_item;

uniform sampler2D input_texture;
uniform sampler2D butterfly_texture;
uniform int stage;
uniform int direction; // 0 = horizontal, 1 = vertical

void fragment() {
    ivec2 size = texture_size(input_texture, 0);
    vec2 uv = UV;

    int N = size.x;
    int half_N = N >> 1;

    // Convert UV to pixel coordinate
    int x = int(uv.x * float(N));
    int y = int(uv.y * float(N));

    int stage_size = 1 << stage;
    int offset = x % stage_size;

    int butterfly_index = offset;

    float twiddle_real = texelFetch(butterfly_texture, ivec2(stage, 0), 0).r;
    float twiddle_imag = texelFetch(butterfly_texture, ivec2(stage, 0), 0).g;

    vec2 a = texelFetch(input_texture, ivec2(x, y), 0).rg;
    vec2 b = texelFetch(input_texture, ivec2(x + stage_size, y), 0).rg;

    // Complex multiply: b * twiddle
    float br = b.x * twiddle_real - b.y * twiddle_imag;
    float bi = b.x * twiddle_imag + b.y * twiddle_real;

    vec2 result;
    if (offset < stage_size / 2) {
        result = vec2(a.x + br, a.y + bi);
    } else {
        result = vec2(a.x - br, a.y - bi);
    }

    COLOR = vec4(result, 0.0, 1.0);
}
