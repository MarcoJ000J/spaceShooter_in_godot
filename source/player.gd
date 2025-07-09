extends Node2D

const aceleration = 300.0
const max_speed = 300.0
const atrito = aceleration*2

var velocity = Vector2.ZERO

signal hit

var screen_size

func _ready() -> void:
	$AnimatedSprite2D.rotation_degrees = 90
	$AnimatedSprite2D.play()
	
	screen_size = get_viewport_rect().size


func _process(delta: float) -> void:
	move(delta)
	
	pass


func move(delta):
	#later change to state machine
	var input_vector = Vector2.ZERO
	
	#X axis
	if Input.is_action_pressed("right"):
		input_vector.x += 1
	if Input.is_action_pressed("left"):
		input_vector.x -= 1
	#Y axis
	if Input.is_action_pressed("up"):
		input_vector.y -= 1
	if Input.is_action_pressed("down"):
		input_vector.y += 1
	
	#input
	input_vector = input_vector.normalized()
	
	#if there is input
	if input_vector != Vector2.ZERO:
		velocity += input_vector * aceleration * delta
		
		#handle the limit
		if velocity.length() > max_speed:
			velocity = velocity.normalized() * max_speed
	#friction
	else:
		#why?
		if velocity.length() > 0:
			var friction_force = atrito * delta
			if velocity.length() <= friction_force:
				velocity = Vector2.ZERO
			else:
				velocity -= velocity.normalized() * friction_force
	
	position += velocity * delta
	
	#handle the limits of the screen
	if position.x <= 0 and velocity.x < 0:
		velocity.x = 0
	if position.x >= screen_size.x and velocity.x > 0:
		velocity.x = 0
	
	if position.y <= 0 and velocity.y < 0:
		velocity.y = 0
	if position.y >= screen_size.y and velocity.y > 0:
		velocity.y = 0
	
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(body: Node2D) -> void:
	hit.emit()
	
	#temporary
	hide()
	#why?
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	
	$CollisionShape2D.disabled = false
