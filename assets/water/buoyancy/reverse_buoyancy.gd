extends Node

@export var oceanTransform : Node3D
@export var buoyancyProbe : Node3D
@export var verticalOffset : float

var t = 0.0

func _physics_process(delta: float) -> void:
	update_ocean_transform(delta)

func update_ocean_transform(delta: float) -> void:
	if oceanTransform == null:
		print("Reversed Buoyancy | OceanTransform not set")
		return
	if buoyancyProbe == null:
		print("Reversed Buoyancy | BuoyancyProbe not set")
		return

	# position
	var targetY = - buoyancyProbe.global_position.y + verticalOffset
	var targetPosition = Vector3(0, targetY, 0)
	oceanTransform.global_position = targetPosition

	# rotation
	var targetRotation = Quaternion(buoyancyProbe.transform.basis.y, Vector3.UP)
	
	oceanTransform.transform.basis = Basis(targetRotation)

	#oceanTransform.basis = buoyancyProbe.basis
