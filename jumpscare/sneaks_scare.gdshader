shader_type canvas_item;

uniform bool flashing = false;
uniform bool wega_color = false;

void fragment() {
	vec4 texture = texture(TEXTURE, UV);
	if (wega_color) {
		COLOR = texture.rbga;
	} else {
		COLOR = texture;
	}
	if (flashing) {
		COLOR += vec4(sin(TIME * 25.0) * 0.25 + 0.1);
	}
}
