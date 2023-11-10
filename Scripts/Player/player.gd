extends CharacterBody2D
class_name Player

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

@export var speed = 300.0
@export var jump = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	GameManager.player = self

func _physics_process(delta):
	if Input.is_action_just_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
	if Input.is_action_just_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)

# Handle gravity
	if not is_on_floor():
		velocity.y += gravity * delta

# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump
#Handle direction
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
# call fucn
	update_animation()
	move_and_slide()
	
	if position.y >= 500:
		die()
	
#  movement btn of the player
func update_animation():
	if velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")
	if velocity.y < 0 :
		animation.play("jump")
	if velocity.y > 0:
		animation.play("fall")
		
#  die fucn
func die():
	GameManager.reswan_player()
