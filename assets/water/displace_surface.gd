extends Node3D

@export var meshInstance : MeshInstance3D
@export var positionPropertyName : String = "displace_obj_positions"
@export var scalePropertyName : String = "displace_obj_scales"
@export var strengthPropertyName : String = "displace_obj_strengths"
@export var objectAmountPropertyName : String = "displace_obj_amount"
#@export var displacementStrength : float = 1
#@export var displacerObject : Node3D

@export var displacerObjects : Array[Node3D]

var material


func _ready() -> void:
	material = meshInstance.get_material_override()

	for displacerObject in displacerObjects:
		print(displacerObject.position, ",", displacerObject.displacementStrength)

func _process(delta):
	# Displacement position
	#material.set_shader_parameter(positionPropertyName, displacerObject.position)
	
	# Displacement scale
	#material.set_shader_parameter(scalePropertyName, displacerObject.scale.x)
	
	# Displacement strength
	#material.set_shader_parameter(strengthPropertyName, displacementStrength)

	# rewriting to send an array of objects
	# can this be handled cleaner, can we send a custom struct?

	material.set_shader_parameter(objectAmountPropertyName, displacerObjects.size());
	
	if displacerObjects.size() <= 0:
		return

	# send arrays to the shader for positions, scales and strengths.
	# not required to run in process, only for debugging during editing.

	var displacerObjectPositions: Array[Vector3]
	var displacerObjectScales: Array[float]
	var displacerObjectStrengths: Array[float]

	for displacerObject in displacerObjects:
		displacerObjectPositions.append(displacerObject.position)
		displacerObjectScales.append(displacerObject.scale.x)
		displacerObjectStrengths.append(displacerObject.displacementStrength)
	
	material.set_shader_parameter(positionPropertyName, displacerObjectPositions)
	material.set_shader_parameter(scalePropertyName, displacerObjectScales)
	material.set_shader_parameter(strengthPropertyName, displacerObjectStrengths)
		
