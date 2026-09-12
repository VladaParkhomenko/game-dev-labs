extends CharacterBody2D
@export var speed: float = 200.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
func _physics_process(_delta: float) -> void:
	#WASD
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if direction != Vector2.ZERO:
		velocity = direction * speed
		animated_sprite.play("run")
		animation_player.play("run_anim") 
		if direction.x < 0:
			animated_sprite.flip_h = true  
		elif direction.x > 0:
			animated_sprite.flip_h = false 
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)
		animated_sprite.play("idle")
		animation_player.play("idle_anim")
	move_and_slide()
