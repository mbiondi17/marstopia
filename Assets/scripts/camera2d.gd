extends Camera2D

#movement vars
export var start_position = Vector2() #the starting pos of the camera
export var speed = 200
export var mouse_speed = 50
export var limit_camera = Vector2()
export var zoom_speed = 20.0
export var limit_zoom = Vector2()
var direction = Vector2()
var time_factor = 1.0 #accelerate the camera movement
var prev_mouse_pos = Vector2(0,0)
var curr_mouse_pos = Vector2(0,0)
var goalPosition = Vector2(0,0)
var decelerate = false


#shake vars
export var decay = 1.5
export var max_offset = Vector2(20, 14)
export var max_roll = 0.1
export (NodePath) var target # use for a following camera
export var trauma_pow = 2
onready var noise = OpenSimplexNoise.new()
var noise_y = 0
var trauma = 0.0
var shake_start = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	set_shake_vars(4,2,2,0.5)
	position = start_position

func _process(delta):
	if trauma:
		shake()
		trauma = max(trauma - decay * delta, 0)
		
	process_mouse_movement(delta)
	process_keyboard_movement(delta)
	process_keyboard_zoom(delta)

func _input(event):
	# need to do mouse wheel things here, since there is no pressed state on them.
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_WHEEL_UP:
			zoom.x -= zoom_speed * 0.048 # seconds in three frames at 60fps.
			zoom.y -= zoom_speed * 0.048 # just an estimate
			zoom.x = clamp(zoom.x, limit_zoom[0], limit_zoom[1])
			zoom.y = clamp(zoom.y, limit_zoom[0], limit_zoom[1])
		if event.button_index == BUTTON_WHEEL_DOWN:
			zoom.x += zoom_speed * 0.048 # seconds in three frames at 60fps.
			zoom.y += zoom_speed * 0.048 # just an estimate
			zoom.x = clamp(zoom.x, limit_zoom[0], limit_zoom[1])
			zoom.y = clamp(zoom.y, limit_zoom[0], limit_zoom[1])

func process_mouse_movement(delta):
	var mouse_movement = Vector2()
	if Input.is_action_just_pressed("Click"):
		prev_mouse_pos = get_viewport().get_mouse_position()
		curr_mouse_pos = get_viewport().get_mouse_position()
	if Input.is_action_pressed("Click"): # are we clickin' and draggin'?
		prev_mouse_pos = curr_mouse_pos
		curr_mouse_pos = get_viewport().get_mouse_position()
		mouse_movement = -(curr_mouse_pos - prev_mouse_pos)
	if Input.is_action_just_released("Click"):
		decelerate = true
		goalPosition = position + (-1.5) * (curr_mouse_pos - prev_mouse_pos) * zoom.x
		
	if mouse_movement.length() > 0:
		position.x += mouse_movement.x * mouse_speed * zoom.x * delta
		position.y += mouse_movement.y * mouse_speed * zoom.y * delta
		position.x = clamp(position.x, -limit_camera[0], limit_camera[0]) 
		position.y = clamp(position.y, -limit_camera[1], limit_camera[1]) 
	elif (position - goalPosition).length() > 3 && decelerate:
		position = position.move_toward(goalPosition, (position - goalPosition).length() * .2)
	elif (position - goalPosition).length() < 3:
		decelerate = false

func process_keyboard_movement(delta):
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	elif Input.is_action_pressed("ui_down"):
		direction.y = 1
	else:
		direction.y = 0
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1
	else:
		direction.x = 0
		
	var velocity = direction.normalized() * speed * zoom.x
	if velocity.length() > 0:
		time_factor += delta #increase velocity
		time_factor = clamp(time_factor, 0, 3)
		position += velocity * time_factor * delta
		position.x = clamp(position.x, -limit_camera[0], limit_camera[0]) 
		position.y = clamp(position.y, -limit_camera[1], limit_camera[1]) 
	else:
		time_factor = 1.0 #reset when the camera stops moving

func process_keyboard_zoom(delta):
	var zoom_direction = 0
	if Input.is_action_pressed("zoom_in_key"):
			zoom_direction = -1
	if Input.is_action_pressed("zoom_out_key"):
			zoom_direction = 1
	if zoom_direction != 0:
		zoom.x += zoom_direction * delta * zoom_speed
		zoom.y += zoom_direction * delta * zoom_speed
		zoom.x = clamp(zoom.x, limit_zoom[0], limit_zoom[1])
		zoom.y = clamp(zoom.y, limit_zoom[0], limit_zoom[1])

func set_shake_vars(period = 64, octaves = 3, lacunarity = 2, persistence = 0.5):
	noise.seed = randi()
	noise.period = period
	noise.octaves = octaves
	noise.lacunarity = lacunarity
	noise.persistence = persistence

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)

func shake():
	var amount = pow(trauma, trauma_pow) #always <= 1
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed * 2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed * 3, noise_y)
	#needed for a static camera
	if(!target):
		position.x = shake_start.x + offset.x
		position.y = shake_start.y + offset.y
