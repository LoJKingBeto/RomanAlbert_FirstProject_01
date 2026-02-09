extends CharacterBody2D

@export var speed: float = 250.0
@export var jump_velocity: float = -420.0
@export var climb_speed: float = 180.0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var on_ladder: bool = false

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	if anim.sprite_frames != null and anim.sprite_frames.has_animation("Idle"):
		anim.play("Idle")

func _physics_process(delta: float) -> void:
	var left: float = Input.get_action_strength("ui_left")
	var right: float = Input.get_action_strength("ui_right")
	var dir_x: float = right - left

	# Horizontal movement always allowed
	velocity.x = dir_x * speed

	if on_ladder:
		# No gravity while on ladder
		var up: float = Input.get_action_strength("ui_up")
		var down: float = Input.get_action_strength("ui_down")
		velocity.y = (down - up) * climb_speed

		# Optional: jump to leave ladder
		if Input.is_action_just_pressed("ui_accept"):
			on_ladder = false
			velocity.y = jump_velocity
	else:
		# Normal gravity + jump
		if not is_on_floor():
			velocity.y += gravity * delta

		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = jump_velocity

	move_and_slide()

func _on_ladder_detector_area_entered(area: Area2D) -> void:
	if area.is_in_group("ladders"):
		on_ladder = true
		velocity.y = 0.0

func _on_ladder_detector_area_exited(area: Area2D) -> void:
	if area.is_in_group("ladders"):
		on_ladder = false


func _on_coin_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.add_score(1)
		queue_free()

	pass # Replace with function body.
