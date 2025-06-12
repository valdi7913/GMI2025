@tool
extends MeshInstance3D

@export var width: int = 100
@export var depth: int = 100
@export var step: float = 1.0

func _ready():
	print("hello")
	if Engine.is_editor_hint():
		mesh = generate_grid_mesh(width, depth, step)

func generate_grid_mesh(width: int, depth: int, step: float) -> ArrayMesh:
	var mesh = ArrayMesh.new()
	var vertices = PackedVector3Array()
	var indices = PackedInt32Array()

	for z in range(depth):
		for x in range(width):
			vertices.append(Vector3(x * step, 0.0, z * step))

	for z in range(depth - 1):
		for x in range(width - 1):
			var i = z * width + x
			var iR = i + 1
			var iD = i + width
			var iDR = i + width + 1
			indices.append_array([i, iD, iR, iR, iD, iDR])

	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_INDEX] = indices

	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return mesh
