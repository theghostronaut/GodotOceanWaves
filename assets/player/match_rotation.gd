extends Node

@export var nodeToMatch : Node3D
@export var nodeToMatchTo : Node3D
@export_range(0, 1) var weight: float = 1

func _process(delta: float) -> void:
	var zeroBasis = Basis.IDENTITY
	var nodeToMatchToBasis = Quaternion(nodeToMatchTo.basis)
	var targetBasis = zeroBasis.slerp(nodeToMatchToBasis, weight)

	nodeToMatch.basis = Basis(targetBasis)
