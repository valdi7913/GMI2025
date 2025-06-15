extends Node

@onready var viewport_a := $ViewportA
@onready var viewport_b := $ViewportB

@onready var rect_a: SubViewport = viewport_a.get_node("TextureRect")
@onready var rect_b := viewport_b.get_node("TextureRect")

@onready var shader_a := rect_a.material
@onready var shader_b := rect_b.material

# Called when the node enters the scene tree for the first time.
func _ready():
	$ViewportA.size = Vector2i(256, 256)
	$ViewportA.render_target_v_flip = true  # usually needed

