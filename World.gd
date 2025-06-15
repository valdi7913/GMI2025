extends Node3D

func _process(delta):
	if(Input.is_action_just_pressed("escape")):
		get_tree().quit()

func _ready():
	var plane = MeshInstance3D.new()
	plane.mesh = PlaneMesh.new()
	plane.mesh.size = Vector2(1, 1)
	plane.mesh.subdivide_depth = 256
	plane.mesh.subdivide_width = 256
	add_child(plane)
	plane.
