shader_type canvas_item;
uniform sampler2D NOISE_PATTERN;
uniform float threshold = 0.5;

void fragment() {
	vec4 noise_sample = texture(NOISE_PATTERN, UV);
	float sample_luminosity = noise_sample.r * 0.299 + noise_sample.g * 0.587 + noise_sample.b * 0.114;
	float stepped_noise;
	if (sample_luminosity > threshold) {
		stepped_noise = 0.0;
	} else {
		stepped_noise = 1.0;
	}
	vec3 stepped_noise_sample = vec3(stepped_noise, stepped_noise, stepped_noise);
	COLOR = vec4(COLOR.rgb + stepped_noise_sample * 0.2, COLOR.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
