extends Area2D

@onready var _animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var marker_node: Marker2D = $Marker2D

var is_active := false

func _ready() -> void:
	if _animation:
		_animation.play("cp")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not is_active:
		activate_checkpoint(body)

func activate_checkpoint(player: Node2D) -> void:
	is_active = true
	if _animation:
		_animation.play("cp")
	
	var new_pos = marker_node.global_position if marker_node else global_position
	
	if "last_checkpoint_pos" in player:
		player.last_checkpoint_pos = new_pos
		print("Checkpoint Berhasil Disimpand!")
