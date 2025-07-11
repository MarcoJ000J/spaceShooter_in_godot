extends Area2D

var speed = 1000.0
var right = false

signal bullet_hit

var screen_border

var who_shoot : Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.rotation_degrees = 90
	$AnimatedSprite2D.play("move3")
	 
	screen_border = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if right == false:
		velocity.x = 1
	elif right == true:
		velocity.x = -1
	
	position += velocity * speed * delta
	
	#destroy the bullet when out of the scene
	if position.x >= screen_border.x or position.x <= 0:
		queue_free()
	if position.y >= screen_border.y or position.y <= 0:
		queue_free()
	
	pass


func setup(group: String, who_is_shooting : Node):
	
	if group == "player":
		right = false 
	elif group == "enemy":
		right = true
	
	who_shoot = who_is_shooting


func _on_area_entered(area: Area2D):
	if area == who_shoot:
		print("pqp")
		return
	else:
		bullet_hit.emit()
		$CollisionShape2D.disabled = true
		
		speed = 0
		
		$AnimatedSprite2D.play("explode")
		await $AnimatedSprite2D.animation_finished
		queue_free()
		
