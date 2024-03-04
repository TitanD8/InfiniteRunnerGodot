extends CharacterBody2D
@onready var _animationPlayer = $AnimationPlayer
@export var move_speed : float = 8000.0
@export var jump_height : float = 10.0
@export var jump_time : float = 1.0
var jump_current : float = -1.0

#Fall Check Variables
var was_in_air : bool = false
var is_jumping : bool = false

const base_speed : float = 8000.0

# Called when the node enters the scene tree for the first time.
func _ready():
	_animationPlayer.play("run")

func _input(event):
# If the player presses the key to slow down the animation changes to walk and the characters movement
# speed is decreased.
	if event.is_action_pressed("walk"):
		_animationPlayer.play("walk")
		move_speed -= 4000.0

#When the player releases the slow key the characters animation will change to run and the characters
# movement speed will return to normal.
	if event.is_action_released("walk"):
		_animationPlayer.play("run")
		move_speed = base_speed

# If the player pressed the key to speed up the characters animation will change to run and the characters
# movement speed is increased.
	if event.is_action_pressed("sprint"):
		_animationPlayer.play("run")
		move_speed += 3000.0

# If the player releases the key to speed up the characters animation will change to run and the characters
# speed returns to normal.
	if event.is_action_released("sprint"):
		_animationPlayer.play("run")
		move_speed = base_speed
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	print(is_jumping)
# If character is not on the ground apply gravity.
	if !is_on_floor():
		velocity.y += 40

# Handles jump physics and allows for a variable jump, meaning the longer the player holds the key,
# The higher the player will travel before they reach the peak of the jump and begin to fall.
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			jump_current = jump_time
			velocity.y -= jump_height
			is_jumping = true
		else:
			if is_jumping:
				jump_current -= delta
				if jump_current > 0:
					velocity.y = min(velocity.y, -jump_height * (jump_current / jump_time) )

	if Input.is_action_just_released("jump"):
		is_jumping = false
# JUMP ANIMATION CONTROL
# If player is on floor: 
	# and their movement speed is equal to or greater than default speed, play "run" animation.
	# and their movement speed is less than default speed (8000), play "walk" animation.
# If player is not on floor:
	# and their y velocity is greater than 0, play "jump" animation.
	# and their y velicity is less than 0, play "fall" animation.
	if is_on_floor():
		if move_speed >= 8000:
			_animationPlayer.play("run")
		else:
			_animationPlayer.play("walk")
			
	else:
		if velocity.y < 0:
			_animationPlayer.play("jump")
		else:
			_animationPlayer.play("fall")

# Apply constant movement with variable speed to character.
	velocity.x = move_speed * delta
	
	move_and_slide()
	pass
