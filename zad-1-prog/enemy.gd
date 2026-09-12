extends CharacterBody2D
@export var speed: float = 140.0
@onready var player: CharacterBody2D = get_node("../Player")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var gotcha_bubble: Sprite2D = $GotchaBubble 
var slide_timer: float = 0.0
func _physics_process(_delta: float) -> void:
	if player:
		var target_direction = global_position.direction_to(player.global_position)
		
		if slide_timer > 0:
			slide_timer -= _delta
			var orthogonal = Vector2(-target_direction.y, target_direction.x)
			velocity = (target_direction + orthogonal * 1.5).normalized() * speed
		else:
			velocity = target_direction * speed
			
		animated_sprite.play("run")
		
		if target_direction.x < 0:
			animated_sprite.flip_h = true
		elif target_direction.x > 0:
			animated_sprite.flip_h = false
			
		move_and_slide()
		
		if get_slide_collision_count() > 0 and velocity.length() < 10.0:
			slide_timer = 0.5
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		gotcha_bubble.visible = true 
		print("Player caught! Damage dealt.")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		gotcha_bubble.visible = false 
