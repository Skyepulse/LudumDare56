shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 color = textureLod(screen_texture, SCREEN_UV,0);
	COLOR = color;

}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
