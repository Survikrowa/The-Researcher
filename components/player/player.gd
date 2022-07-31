extends KinematicBody2D 

onready var animation = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var sprite = $Sprite
var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2()
var mouse_direction: Vector2 = Vector2()

func _physics_process(delta):
	handle_player_input()
	handle_player_facing()

func handle_player_facing():
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport().size

	var mouse_pos_from_center_x = mouse_pos.x - (screen_size.x/2)
	var mouse_pos_from_center_y = mouse_pos.y - (screen_size.y/2)

	mouse_direction = Vector2(mouse_pos_from_center_x, mouse_pos_from_center_y)
	if mouse_direction[0] > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	animation_tree.set('parameters/Idle/blend_position', mouse_direction)
	animation_tree.set('parameters/Walk/blend_position', mouse_direction)	

func handle_player_input():
	velocity = Vector2()
	if(Input.is_action_pressed("right")):
		velocity.x += 1
		direction = Vector2(1, 0)
	if(Input.is_action_pressed("left")):
		velocity.x -= 1
		direction = Vector2(-1, 0)
	if(Input.is_action_pressed("up")):
		velocity.y -= 1
		direction = Vector2(0, -1)
	if(Input.is_action_pressed("down")):
		velocity.y += 1
		direction = Vector2(0, 1)
	var normalized_velocity = velocity.normalized()
	if velocity == Vector2.ZERO:
		animation_tree.get('parameters/playback').travel('Idle')
	else:
		velocity = move_and_slide(normalized_velocity * 100)		
		animation_tree.get('parameters/playback').travel('Walk')
