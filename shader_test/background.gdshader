shader_type canvas_item;
uniform sampler2D NOISE_PATTERN;
uniform float land_threshold = 0.5;
uniform float beach_threshold = 0.45;
uniform float mountain_threshold = 0.85;
uniform vec4 water_color : source_color = vec4(1.0);
uniform vec4 beach_color : source_color = vec4(1.0);
uniform vec4 land_color : source_color = vec4(1.0);
uniform vec4 mountain_color : source_color = vec4(1.0);
uniform float resolution = 100.0;
uniform int blur = 1;

float luminosity(in vec4 color) {
	return color.r * 0.299 + color.g * 0.587 + color.b * 0.114;
}

vec4 elevation_to_color(float elevation) {
	if (elevation < beach_threshold) {
		return water_color;
	} else if (elevation < land_threshold) {
		return beach_color;
	} else if (elevation < mountain_threshold) {
		return land_color;
	}
	return mountain_color;
}

void fragment() {
	vec4 total_color = vec4(0.0);
	for (int i = -blur; i <= blur; i++) {
		for (int j = -blur; j <= blur; j++) {
			vec2 sample_point = vec2(floor(UV.x * resolution) + float(i), floor(UV.y * resolution) + float(j)) / resolution;
			vec4 noise_sample = texture(NOISE_PATTERN, sample_point);
			float elevation = luminosity(noise_sample);
			total_color += elevation_to_color(elevation);
		}
	}
	COLOR = total_color / (4.0 * float(blur) * float(blur) + 4.0 * float(blur) + 1.0);
}