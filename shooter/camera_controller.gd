extends Node3D
class_name CameraController

var player_controller: VehicleController
var input_rotation: Vector3
var mouse_input: Vector2
var mouse_sensitivity: float = 0.005

var use_interpolation: bool = false
var circle_strafe: bool = true

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player_controller = get_parent()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_input.x += -event.screen_relative.x * mouse_sensitivity
		mouse_input.y += -event.screen_relative.y * mouse_sensitivity

func _physics_process(_delta: float) -> void:
	input_rotation.x = clampf(input_rotation.x + mouse_input.y, deg_to_rad(-90), deg_to_rad(85))
	input_rotation.y += mouse_input.x
	
	player_controller.camera_anchor.transform.basis = Basis.from_euler(Vector3(input_rotation.x, input_rotation.y, 0.0))
	global_transform = player_controller.camera_anchor.get_global_transform_interpolated()
	mouse_input = Vector2.ZERO
