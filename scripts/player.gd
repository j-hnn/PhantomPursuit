class_name Player extends CharacterBody2D

@onready var muzzle = $Muzzle

@export var speed = 300

var dir : Vector2
var reload_time = 0.1
var can_fire = true

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	velocity = dir * speed
	move_and_slide()
	
	if Input.is_action_pressed("click") and can_fire:
		print("firing laser")
		fire_laser()
			
func _unhandled_input(_event):
	dir.x = Input.get_axis("ui_left", "ui_right")
	dir.y = Input.get_axis("ui_up", "ui_down")
	dir = dir.normalized()

func fire_laser():
	can_fire = false
	var laser = load("res://scenes/laser.tscn").instantiate()
	laser.global_position = Vector2(muzzle.global_position.x, muzzle.global_position.y)
	laser.rotation = self.rotation
	get_parent().add_child(laser)
	await get_tree().create_timer(reload_time).timeout 
	can_fire = true
