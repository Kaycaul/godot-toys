shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 texture = texture(TEXTURE, UV);
	float luminosity = texture.r * 0.299 + texture.g * 0.587 + texture.b * 0.114;
	COLOR = vec4(luminosity, 0.0, (1.0 - luminosity), 1.0);
	COLOR += sin(UV.x * PI * 5.0) * 0.2;
	COLOR += sin(UV.y * PI * 5.0) * 0.2;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
