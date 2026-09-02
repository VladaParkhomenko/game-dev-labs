extends CharacterBody2D

@export var speed: float = 200.0

func _physics_process(delta: float) -> void:
	#WASD i strzałki
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction:
		velocity = direction * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)
	
	move_and_slide()
