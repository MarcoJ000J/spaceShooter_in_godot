extends Area2D

const speed = 300.0

signal bullet_hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.rotation_degrees = 90
	$AnimatedSprite2D.play("move")
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	velocity.x = 1
	
	position += velocity * speed * delta
	
	pass



func _on_body_entered(body: Node2D) -> void:
	bullet_hit.emit()
	
	$AnimatedSprite2D.play("explode")
	
	
