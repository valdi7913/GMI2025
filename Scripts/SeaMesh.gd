extends MeshInstance3D

const SIZE_X = 100
const SIZE_Z = 100
const STEP = 1.0

func _ready():
	var mesh = generate_grid_mesh(SIZE_X, SIZE_Z, STEP)
	self.mesh = mesh

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
