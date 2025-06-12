extends Node3D

func _ready():
	var mesh = generate_grid_mesh(100, 100, 1.0)

	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = mesh
	add_child(mesh_instance)

	var light = DirectionalLight3D.new()
	light.rotation_degrees = Vector3(45, 0, 0)
	add_child(light)

func generate_grid_mesh(width: int, depth: int, step: float) -> ArrayMesh:
	var mesh = ArrayMesh.new()
	var vertices = PackedVector3Array()
	var indices = PackedInt32Array()
	var uvs = PackedVector2Array()

	# Generate vertices and UVs
	for z in range(depth):
		for x in range(width):
			vertices.append(Vector3(x * step, 0.0, z * step))
			uvs.append(Vector2(x / float(width - 1), z / float(depth - 1)))

	# Generate triangle indices (two triangles per square)
	for z in range(depth - 1):
		for x in range(width - 1):
			var top_left = z * width + x
			var top_right = top_left + 1
			var bottom_left = top_left + width
			var bottom_right = bottom_left + 1

			# First triangle
			indices.append(top_left)
			indices.append(bottom_left)
			indices.append(top_right)

			# Second triangle
			indices.append(top_right)
			indices.append(bottom_left)
			indices.append(bottom_right)

	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_INDEX] = indices
	arrays[Mesh.ARRAY_TEX_UV] = uvs

	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return mesh

func _process(delta):
	if(Input.is_action_just_pressed("escape")):
		get_tree().quit()
