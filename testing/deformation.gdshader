shader_type spatial;
render_mode world_vertex_coords;

uniform vec3 displace_obj_position = vec3(0,1,0);
uniform float displace_obj_scale = 1.0;
uniform float displace_obj_strength = 2.0;

void vertex() {    

    float radius = displace_obj_scale;
    float max = 0.0;
    
	float displace_obj_radius = displace_obj_scale/2.0;
	vec3 displace_obj_position_edge = vec3(
		displace_obj_position.x, 
		displace_obj_position.y + displace_obj_radius, 
		displace_obj_position.z
		);
    float distance_vertex_to_obj = length(VERTEX - displace_obj_position_edge);
    
    if (radius > 0.0)
    {
        float displacementFactor = smoothstep(radius, max, distance_vertex_to_obj);
        VERTEX.y -= displacementFactor * displace_obj_strength;
    }
}