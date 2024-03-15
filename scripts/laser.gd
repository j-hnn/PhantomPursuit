extends CharacterBody2D

var speed = 500

func _ready():
	await get_tree().create_timer(5).timeout
	queue_free()
	
func _physics_process(delta):
	velocity = transform.x * speed
	move_and_slide()
	
func _on_hitbox_body_entered(body):
	queue_free()
	if body is Phantom:
		body.queue_free()
