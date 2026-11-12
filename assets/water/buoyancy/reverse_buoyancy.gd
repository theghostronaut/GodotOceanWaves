extends Node

@export var oceanTransform : Node3D
@export var buoyancyProbe : Node3D
@export var verticalOffset : float
@export var positionSmoothSpeed : float = 0.4
@export var rotationSmoothSpeed : float = 0.4

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
	var targetPosition = Vector3(oceanTransform.global_position.x, targetY, oceanTransform.global_position.z)

	#t += delta * positionSmoothSpeed
	#oceanTransform.global_position = oceanTransform.global_position.lerp(targetPosition, t)
	oceanTransform.global_position = targetPosition

	# rotation
	# TODO: Something wrong here with the rotation calc. Ocean rolls to side after some time and doesnt recover.
	#var targetQuaternion = Quaternion(buoyancyProbe.transform.basis.y, global_transform.basis.y)
	var targetRotation = Quaternion(buoyancyProbe.transform.basis.y, Vector3.UP)
	#var targetRotation = buoyancyProbe.global_rotation
	
	oceanTransform.transform.basis = Basis(targetRotation)

	#oceanTransform.global_rotation = oceanTransform.global_rotation.lerp(targetRotation, delta * rotationSmoothSpeed)
	#oceanTransform.global_rotation = targetRotation
