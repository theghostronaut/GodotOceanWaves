extends Node

@export var target : Node3D
@export var buoyancyProbe : Node3D
@export var verticalOffset : float

func _physics_process(delta: float) -> void:
	update_ocean_transform(delta)

func update_ocean_transform(delta: float) -> void:
	if target == null:
		print("Reversed Buoyancy | No target is set")
		return
	if buoyancyProbe == null:
		print("Reversed Buoyancy | BuoyancyProbe not set")
		return

	# position
	var y = - buoyancyProbe.global_position.y + verticalOffset
	var targetPosition = Vector3(0, y, 0)
	target.global_position = targetPosition

	# rotation
	var targetRotation = Quaternion(buoyancyProbe.transform.basis.y, Vector3.UP)
	target.transform.basis = Basis(targetRotation)
