extends Node2D

const aceleration = 50.0
var speed = 0
const max_speed = 300.0


func _ready() -> void:
	$AnimatedSprite2D.rotation_degrees = 90
	$AnimatedSprite2D.play()
	
	pass

func _process(delta: float) -> void:
	#later change to state machine
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	
	#is this right?
	if !Input.is_anything_pressed():
		var atrito = 50.0
		if speed > 0: 
			speed -= speed - atrito
		if speed < 0:
			speed += speed + atrito
	
	
	#correct this to use eceleration
	if velocity.length() > 0:
		velocity += velocity.normalized() * speed
	
	position += velocity * delta
	
	pass
