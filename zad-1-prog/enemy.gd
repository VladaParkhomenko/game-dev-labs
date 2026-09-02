extends CharacterBody2D

@export var speed: float = 140.0
@onready var player: CharacterBody2D = get_node("../Player")

func _physics_process(delta: float) -> void:
	if player:
		#direction to Player
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed

		move_and_slide()
