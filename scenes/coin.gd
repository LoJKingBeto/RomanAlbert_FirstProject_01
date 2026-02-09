extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	sprite.play("spin")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.add_score(1)
		sfx.play()
		hide()
		$CollisionShape2D.disabled = true
		await sfx.finished
		queue_free()


	if body is CharacterBody2D:
		GameManager.add_score(1)
		sfx.play()
		hide()
		$CollisionShape2D.disabled = true
		await sfx.finished
		queue_free()
