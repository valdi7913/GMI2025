extends Camera3D

@export var SPEED : float = 5.0;

# Mouse sensitivity
var mouse_sensitivity := 0.1

# Vertical angle limit (in degrees)
var min_pitch := -89.0
var max_pitch := 89.0

# Internal rotation tracking
var pitch := 0.0  # Up/down
var yaw := 0.0    # Left/right

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# Update yaw and pitch based on mouse motion
		yaw -= event.relative.x * mouse_sensitivity
		pitch -= event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, min_pitch, max_pitch)

		# Apply rotation
		rotation_degrees = Vector3(pitch, yaw, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector3(0,0,0);
	
	if(Input.is_action_pressed("forwards")):
		direction -= self.get_global_transform().basis.z
	elif(Input.is_action_pressed("backwards")):
		direction += self.get_global_transform().basis.z;
		
	if(Input.is_action_pressed("left")):
		direction -= self.get_global_transform().basis.x;
	elif(Input.is_action_pressed("right")):
		direction += self.get_global_transform().basis.x;
		
	if(Input.is_action_pressed("up")):
		direction.y += 1;
	elif(Input.is_action_pressed("down")):
		direction.y -= 1;
	
	position += direction.normalized() * SPEED * delta;
	pass
