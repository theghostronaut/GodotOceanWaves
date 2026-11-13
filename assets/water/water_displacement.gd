@tool
extends Node3D

@export var water : GeometryInstance3D
var waterMaterial

func _ready() -> void:
	waterMaterial = water.get_material_override()

func _process(delta):
	var displacement_position_propery = waterMaterial.get_shader_parameter("displacement_position")
	displacement_position_propery = position
	waterMaterial.set_shader_parameter("displacement_position", displacement_position_propery)
