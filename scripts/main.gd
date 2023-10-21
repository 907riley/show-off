extends Node3D

# player node
var player: Node3D

# markers for hands
var left_ik: Marker3D
var right_ik: Marker3D

# holds
var left_hold: Node3D
var right_hold: Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	player = $'Player'
	
	left_ik = $'Player/RootNode/Skeleton3D/LeftArmIKTarget'
	right_ik = $'Player/RootNode/Skeleton3D/RightArmIKTarget'	
	
	left_hold = $'wall/left_hold'
	right_hold = $'wall/right_hold'	
	
	print("Left hold:", left_hold.global_position)
	print("Right hold:", right_hold.global_position)	
	player.set_left_hand_position(left_hold.global_position)
	player.set_right_hand_position(right_hold.global_position)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
