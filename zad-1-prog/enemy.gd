extends CharacterBody2D

@export var speed: float = 140.0
@onready var player: CharacterBody2D = get_node("../Player")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		animated_sprite.play("run")
		if direction.x < 0:
			animated_sprite.flip_h = true
		elif direction.x > 0:
			animated_sprite.flip_h = false
			
		move_and_slide()
