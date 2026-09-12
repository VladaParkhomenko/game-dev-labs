extends CharacterBody2D
@export var speed: float = 140.0
@onready var player: CharacterBody2D = get_node("../Player")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var gotcha_bubble: Sprite2D = $GotchaBubble
@onready var ray_front: RayCast2D = $RayFront
@onready var ray_left: RayCast2D = $RayLeft
@onready var ray_right: RayCast2D = $RayRight
var stuck_timer: float = 0.0
var avoid_side: float = 1.0

func _physics_process(_delta: float) -> void:
	if player:
		var target_direction = global_position.direction_to(player.global_position)
		var move_direction = target_direction
		ray_front.target_position = ray_front.to_local(player.global_position).normalized() * 45.0
		if ray_front.is_colliding():
			if stuck_timer <= 0:
				stuck_timer = 0.6
				if ray_left.is_colliding() and not ray_right.is_colliding():
					avoid_side = 1.0  
				elif ray_right.is_colliding() and not ray_left.is_colliding():
					avoid_side = -1.0
				else:
					avoid_side = 1.0 if randf() > 0.5 else -1.0
		if stuck_timer > 0:
			stuck_timer -= _delta
			var orthogonal = Vector2(-target_direction.y, target_direction.x) * avoid_side
			move_direction = (target_direction + orthogonal * 2.0).normalized()
		
		velocity = move_direction * speed
		animated_sprite.play("run")
		if move_direction.x < 0:
			animated_sprite.flip_h = true
		elif move_direction.x > 0:
			animated_sprite.flip_h = false
		move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		gotcha_bubble.visible = true
		print("Player caught! Damage dealt.")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		gotcha_bubble.visible = false
