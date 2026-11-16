extends Node

@export var ocean : Node3D
#@export var oceanSurfaceDisplacement : Node3D
@export var sun : Node3D
@export var buoyancyProbe : Node3D
@export var oceanVerticalOffset : float
@export var worldEnvironment : WorldEnvironment

var initSunBasis

func _ready() -> void:
	initSunBasis = sun.basis

func _physics_process(delta: float) -> void:
	if buoyancyProbe == null:
		print("World Rotation | BuoyancyProbe not set")
		return

	process_ocean(delta)
	process_sun(delta)
	process_sky(delta)

func process_ocean(delta: float) -> void:
	if ocean == null:
		print("World Rotation | No ocean is set")
		return

	# position
	var y = - buoyancyProbe.global_position.y + oceanVerticalOffset
	var targetPosition = Vector3(0, y, 0)
	ocean.global_position = targetPosition

	# rotation
	var targetRotation = Quaternion(buoyancyProbe.basis.y, Vector3.UP)
	ocean.basis = Basis(targetRotation)

	# ocean object displacement
	#if oceanSurfaceDisplacement == null:
		#return
	
	#oceanSurfaceDisplacement.global_position = targetPosition
	#oceanSurfaceDisplacement.basis = Basis(targetRotation)

func process_sun(delta: float) -> void:
	if sun == null:
		print("World Rotation | No sun is set")
		return
	
	var targetBasis = ocean.basis * initSunBasis
	sun.basis = Basis(targetBasis)

func process_sky(delta: float) -> void:
	if worldEnvironment == null:
		print("World Rotation | No World Environment is set")
	
	worldEnvironment.environment.sky_rotation = ocean.rotation
	
