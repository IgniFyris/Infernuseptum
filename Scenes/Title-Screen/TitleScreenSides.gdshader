shader_type canvas_item;

uniform float speed = 2.4;

void vertex() {
	UV.y += TIME * speed;
}

