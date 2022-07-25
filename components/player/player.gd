extends KinematicBody2D

onready var animation = $AnimationPlayer
onready var animation_tree = $AnimationTree
var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2()
	
func _physics_process(delta):
	handle_player_input()


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
		animation_tree.set('parameters/Idle/blend_position', normalized_velocity)
		animation_tree.set('parameters/Walk/blend_position', normalized_velocity)		
