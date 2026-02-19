extends Area2D

@onready var main = get_parent()
@onready var _animated_sprite = $AnimatedSprite2D

func _on_body_entered(body):
	if body.has_method("mati_dan_respawn"):
			body.mati_dan_respawn()
			print("game selesai")

func _ready() -> void:
	if _animated_sprite:
		_animated_sprite.play("end_gate")
