extends Node2D

class_name walls_node

signal bird_crashed
signal point_score

@export var speed = 150
@onready var sprite_1 = $sprite1
@onready var sprite_2 = $sprite2
@onready var sprite_3 = $sprite3
@onready var sprite_4 = $sprite4
@onready var sprite_5 = $sprite5


func _process(delta):
	sprite_1.global_position.x -= speed * delta
	sprite_2.global_position.x -= speed * delta
	sprite_3.global_position.x -= speed * delta
	sprite_4.global_position.x -= speed * delta
	sprite_5.global_position.x -= speed * delta

	if sprite_1.global_position.x <= -150:
		sprite_1.global_position.x = randf_range(800,900)
	if sprite_2.global_position.x <= -300:
		sprite_2.global_position.x = randf_range(950,1050)
	if sprite_3.global_position.x <= -300:
		sprite_3.global_position.x = randf_range(1100,1200)
	if sprite_4.global_position.x <= -300:
		sprite_4.global_position.x = randf_range(1250,1350)
	if sprite_5.global_position.x <= -300:
		sprite_5.global_position.x = randf_range(1400,1500)

func _on_area_entered(area):
	(area is Bird)
	print("no")
	bird_crashed.emit()
	
func _on_point_area_1_area_entered(area):
	point_score.emit()


func _on_point_area_1_body_entered(body):
	point_score.emit()

func _physics_process(delta):
	if Input.is_action_just_pressed("speed_up"):
		speed = speed + 150
	if Input.is_action_just_pressed("speed_down"):
		speed = speed - 50
