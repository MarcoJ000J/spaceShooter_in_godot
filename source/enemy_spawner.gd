extends Node2D

var point = Vector2.ZERO

@export var enemy : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	point.x = get_viewport_rect().size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	
	point.y = randf_range(0, get_viewport_rect().size.y)
	
	var new_enemy = enemy.instantiate()
	add_sibling(new_enemy)
	new_enemy.position = point
	
	new_enemy.add_to_group("enemy")
