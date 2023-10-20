extends Node3D

@onready var skeleton: Skeleton3D = $'Skeleton3D'

var mouse_position_3d: Vector3

# head
var head: Transform3D
var head_id: int

# hands
var left_hand: Transform3D
var left_hand_id: int

var right_hand: Transform3D
var right_hand_id: int 

# arms
var left_forearm: Transform3D
var left_forearm_id: int

var right_forearm: Transform3D
var right_forearm_id: int

# markers for hands
var left_ik: Marker3D
var right_ik: Marker3D

# markers for head
var head_marker: Marker3D

@export var hand_separation: float = .1

# Called when the node enters the scene tree for the first time.
func _ready():
	left_hand_id = skeleton.find_bone("mixamorig_LeftHand")
	left_hand = skeleton.get_bone_pose(left_hand_id)
	
	left_hand_id = skeleton.find_bone("mixamorig_RightHand")
	right_hand = skeleton.get_bone_pose(right_hand_id)	
	
	left_ik = $'Skeleton3D/LeftArmIKTarget'
	right_ik = $'Skeleton3D/RightArmIKTarget'
	
	left_forearm_id = skeleton.find_bone("mixamorig_LeftForeArm")
	right_forearm_id = skeleton.find_bone("mixamorig_RightForeArm")	
	
	skeleton.set_bone_pose_rotation(left_forearm_id, Quaternion(0, -1, 0, 1))
	skeleton.set_bone_pose_rotation(right_forearm_id, Quaternion(0, 1, 0, 1))	
	
	head_id = skeleton.find_bone("mixamorig_Head")
	head = skeleton.get_bone_global_pose(head_id)
	
	head_marker = $'Skeleton3D/Eyes'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	
	


func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	mouse_position_3d = Vector3(position.x, position.y, 0)
	var mouse_position_left: Vector3 = Vector3(mouse_position_3d.x + hand_separation, mouse_position_3d.y, 0)
	var mouse_position_right: Vector3 = Vector3(mouse_position_3d.x - hand_separation, mouse_position_3d.y, 0)	
	
	if not Input.is_action_pressed("hold_left"):
		left_ik.set_position(mouse_position_left)
	if not Input.is_action_pressed("hold_right"):		
		right_ik.set_position(mouse_position_right)	
		
	head = head.looking_at(mouse_position_3d, Vector3(0, 1, 0), true)
#	head = head.orthonormalized()
#	head.basis = head.basis.rotated(head.basis.x, deg_to_rad(5))
	skeleton.set_bone_pose_rotation(head_id, head.basis)
