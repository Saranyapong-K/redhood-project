extends CharacterBody2D


@export var speed = 500.0
@export var jump_velocity = -200.0
const airboned_speed_mult = 0.5
	
func get_input():
	var input_direction = Input.get_vector("left", "right","up","down")
	velocity = input_direction * speed
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
		
	if direction != 0:
		$Sprite2D.flip_h = direction > 0
		
	var current_speed = speed
	
	#slow when airborned
	if not is_on_floor():
		current_speed *= airboned_speed_mult 
	
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		
	if velocity.x != 0 and is_on_floor():
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.stop()
	move_and_slide()
