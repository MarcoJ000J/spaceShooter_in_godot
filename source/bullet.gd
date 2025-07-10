extends Area2D

const speed = 1000.0

signal bullet_hit

var screen_border

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.rotation_degrees = 90
	$AnimatedSprite2D.play("move")
	
	screen_border = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	velocity.x = 1
	
	position += velocity * speed * delta
	
	#destroy the bullet when out of the scene
	if position.x >= screen_border.x or position.x <= 0:
		queue_free()
	if position.y >= screen_border.y or position.y <= 0:
		queue_free()
	
	pass


func _on_body_entered(body: Node2D) -> void:
	bullet_hit.emit()
	
	$AnimatedSprite2D.play("explode")
	#need to fix this
	await 6
	queue_free()
