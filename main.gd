extends Node2D

@onready var player = $Player
@onready var start_checkpoint = $StartCheckpoint

func game_finish():
	print("GAME SELESAI")

	player.global_position = start_checkpoint.global_position
	player.velocity = Vector2.ZERO
