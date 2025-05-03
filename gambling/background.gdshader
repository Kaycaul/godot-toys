shader_type canvas_item;
uniform sampler2D NOISE_PATTERN;
uniform float land_threshold = 0.5;
uniform float beach_threshold = 0.45;
uniform float mountain_threshold = 0.85;
uniform vec4 water_color : source_color = vec4(1.0);
uniform vec4 beach_color : source_color = vec4(1.0);
uniform vec4 land_color : source_color = vec4(1.0);
uniform vec4 mountain_color : source_color = vec4(1.0);

void fragment() {
	vec4 noise_sample = texture(NOISE_PATTERN, UV);
	float elevation = noise_sample.r * 0.299 + noise_sample.g * 0.587 + noise_sample.b * 0.114;
	vec4 terrain_color = mountain_color; // default here instead of an else block
	if (elevation < beach_threshold) {
		terrain_color = water_color;
	} else if (elevation < land_threshold) {
		terrain_color = beach_color;
	} else if (elevation < mountain_threshold) {
		terrain_color = land_color;
	}
	COLOR = terrain_color;
}