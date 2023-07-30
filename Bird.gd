extends CharacterBody2D

class_name Bird

@export var gravity = 900.0
@export var jump_force = -300

@export var rotation_speed = 2
@onready var wall = $"../../Wall_Node" as walls_node
@onready var animation_player = $AnimationPlayer
@onready var ground = $"../../Ground" as Ground

var max_speed = 400
var is_started = false
var should_process_input = true
var walls = preload("res://wall_node.tscn")
var score = 0

func _ready():
	velocity = Vector2.ZERO
	animation_player.play("idle")
	ground.bird_crashed.connect(bird_crashed)
	wall.bird_crashed.connect(bird_crashed)
	wall.point_score.connect(point_scored)

func bird_crashed():
	print("bye bye")
	queue_free()
	get_tree().change_scene_to_file("res://game_over.tscn")
	
func point_scored():
	score = score + 1
	get_parent().get_parent().get_node("RichTextLabel").text = str(score)

func _physics_process(delta):
	if Input.is_action_just_pressed("Jump") && should_process_input:
		if !is_started:
			animation_player.play("flap_wings")
			is_started = true
		jump()


	if !is_started:
		return

	velocity.y += gravity * delta
	
	velocity.y = min(velocity.y, max_speed)
	if velocity.y > max_speed:
		velocity.y = max_speed
		
	move_and_collide(velocity * delta)
	
	rotate_bird()

func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)

func rotate_bird():
	#Rotate downwards when falling
	if velocity.y > 0 and rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
	#Rotate upwards when rising
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		rotation -= rotation_speed * deg_to_rad(1)

func stop():
	animation_player.stop()
	gravity = 0
	velocity = Vector2.ZERO
	max_speed = 0
	jump_force = 0
	should_process_input = false

func _on_body_entered():
	stop()
