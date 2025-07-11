extends Area2D

var speed = 200.0
var inside = false

@export var  bullet: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.rotation_degrees = 270
	$AnimatedSprite2D.play("move")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	velocity.x = -1
	velocity = velocity.normalized()
	
	position += velocity * speed * delta
	
	
	pass



func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	inside = true
	$shoot_Timer.start()


func _on_shoot_timer_timeout() -> void:
	if inside == true:
		var new_bullet = bullet.instantiate()
		new_bullet.setup("enemy", self)
		add_sibling(new_bullet)
		new_bullet.position = self.position
		new_bullet.add_to_group("bullet_enemy")

	
	$shoot_Timer.wait_time = randf_range(0.1, 1)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet_player"):
		#temporary
		hide()
		#why?
		$CollisionShape2D.set_deferred("disabled", true)
		
		queue_free()
