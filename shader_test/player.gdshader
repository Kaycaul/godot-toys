shader_type canvas_item;
uniform vec2 wave_offset;
uniform float red_amount = 1.0;

void vertex() {
	float angle = sin(TIME * 5.0) * PI + PI;
	mat2 rotate_matrix = mat2(
		vec2(cos(angle), sin(angle)),
		vec2(-sin(angle), cos(angle))
	);
	VERTEX *= rotate_matrix;
	VERTEX.x += cos(TIME * 10.0) * 30.0;
	VERTEX.y += sin(TIME * 10.0) * 30.0;
}

void fragment() {
	vec4 texture = texture(TEXTURE, UV);
	float luminosity = texture.r * 0.299 + texture.g * 0.587 + texture.b * 0.114;
	COLOR = vec4(luminosity * red_amount, luminosity * (1.0 - red_amount), (1.0 - luminosity), 1.0);
	COLOR += sin(UV.x * PI * 5.0 + wave_offset.x + (cos(TIME * 10.0))) * 0.2;
	COLOR += sin(UV.y * PI * 5.0 + wave_offset.y + (sin(TIME * 10.0))) * 0.2;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
