extends Node2D

@export var cameraSpeed : float = 130
var startingPosition : float
var finalPosition : float


# Called when the node enters the scene tree for the first time.
func _ready():
	startingPosition = position.x
	finalPosition = 3680
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += cameraSpeed * delta
	pass
