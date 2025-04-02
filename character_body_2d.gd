extends CharacterBody2D
@onready var my_sprite = $AnimatedSprite2D  # Replace with your node path

func _ready() -> void:
	$vic.play()  # Starts playing the default animation

# Called when the node enters the scene tree for the first time.
