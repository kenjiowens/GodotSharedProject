extends CharacterBody2D

var health = 14
enum States { SLAM, CLOSE, BEAM, IDLE }
var state: States = States.IDLE
var plclose = false
var hitboxactive = false
var isattacking = false  # Initially false

var new_scene = preload("res://game_end.tscn")
var random_number = randf()

func _ready() -> void:
	$slash.monitorable = false
	$standing.play("idle")
	state = States.IDLE
	$laserbeam.monitorable = false
	$roararea.monitorable = false

func _process(delta: float) -> void:
	print($slash.get_path()) 
	if hitboxactive:
		print("eduoyhsudyhfhuiosdfhijosdhbojf")
		$slash.monitorable = true
	else:
		$slash.monitorable = false
		print("off")
	if state == States.IDLE:
		pass

	# Only update state if we're not attacking
	if isattacking == false:
		if plclose:
			state = States.CLOSE  # Only start slash if close
		else:
			state = States.IDLE
			return_to_idle()
	if state == States.CLOSE:
		start_slash()
	if health == 0:
		print("won")
		get_tree().change_scene_to_file("res://game_end.tscn")
	if isattacking == false:
		return_to_idle()
	if isattacking == false:  # Don't reset the frame if still attacking
		$Slash.frame = 0

func start_slash():
	if isattacking == false:  # Only start slash if not attacking already
		isattacking = true
		$standing.visible = false
		$Slash.visible = true
		$Slash.play("slashj")

func return_to_idle():
	$Slash.visible = false
	$standing.visible = true
	$standing.play("idle")
	hitboxactive = false
	isattacking = false  # Attack is done, allow next attack
	state = States.IDLE

func _on_slash_animation_finished() -> void:
	pass

func _on_standing_frame_changed() -> void:
	# Enable hitbox when slash animation is in key frames
	if $Slash.frame in [10, 11, 12, 13]:
		hitboxactive = true
	else:
		hitboxactive = false

func _on_slam_body_entered(body: Node2D) -> void:
	if body.name == "chara":
		plclose = true

func _on_slam_body_exited(body: Node2D) -> void:
	print("Char has exited the area!")
	plclose = false

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "attack":
		health -= 1
		print("hit")

func reroll():
	random_number = randf()
	print("New random number:", random_number)

func _on_slash_animation_looped() -> void:
	isattacking = false  # Finished slashing, allow state change
	state = States.IDLE
	return_to_idle()
	print("fuck")
