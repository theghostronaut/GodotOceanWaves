@tool
extends Node3D

@export var mesh_instance : MeshInstance3D
@export var position_property_name : String = "displace_obj_positions"
@export var scale_property_name : String = "displace_obj_scales"
@export var strength_property_name : String = "displace_obj_strengths"
@export var object_amount_property_name : String = "displace_obj_amount"
@export var displacer_objects : Array[Node3D]
@export var refresh : bool :
	set(value):
		initialize()
		refresh = false
@export var update_in_process : bool
@export var toggle_displacer_object_meshes : bool :
	set(value):
		toggle_displace_object_meshes()
		toggle_displacer_object_meshes = false

var material: Material

func _ready() -> void:
	initialize()

func initialize():
	if displacer_objects.size() <= 0:
		return

	# get the material
	material = mesh_instance.get_material_override()

	# set the displacer object array size in the shader
	material.set_shader_parameter(object_amount_property_name, displacer_objects.size());

	# set up the arrays
	var displacer_object_positions: Array[Vector3]
	var displacer_object_scales: Array[float]
	var displacer_object_strengths: Array[float]

	for obj in displacer_objects:
		displacer_object_positions.append(obj.position)
		displacer_object_scales.append(obj.scale.x)
		displacer_object_strengths.append(obj.displacement_strength)
	
	# send to shader
	material.set_shader_parameter(position_property_name, displacer_object_positions)
	material.set_shader_parameter(scale_property_name, displacer_object_scales)
	material.set_shader_parameter(strength_property_name, displacer_object_strengths)

func toggle_displace_object_meshes():
	for obj in displacer_objects:
		for subnode in obj.get_children():
			if subnode is MeshInstance3D:
				subnode.visible = !subnode.visible

func _process(delta: float) -> void:
	if not update_in_process:
		return
	
	initialize()