extends Node

@export var nodeToMatch : Node3D
@export var nodeToMatchTo : Node3D
@export_range(0, 60) var matchSpeed: float = 1

func _process(delta: float) -> void:

	var nodeToMatchBasis = Quaternion(nodeToMatch.basis)
	var nodeToMatchToBasis = Quaternion(nodeToMatchTo.basis)
	var calculatedBasis = nodeToMatchBasis.slerp(nodeToMatchToBasis, matchSpeed * delta)

	nodeToMatch.basis = Basis(calculatedBasis)
