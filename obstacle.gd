extends Area2D

@onready var _animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	if _animated_sprite:
		_animated_sprite.play("saw")

func _on_body_entered(body: Node2D) -> void:
		print("your dead!")
		if body.has_method("mati_dan_respawn"):
			body.mati_dan_respawn()
