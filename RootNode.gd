extends Node3D

@onready var skeleton: Skeleton3D = $'RootNode/Skeleton3D'

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

# shoulders
var left_shoulder: Transform3D
var left_shoulder_id: int

var right_shoulder: Transform3D
var right_shoulder_id: int

# markers for hands
var left_ik: Marker3D
var right_ik: Marker3D

# markers for head
var head_marker: Marker3D

@export var hand_separation: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	left_hand_id = skeleton.find_bone("mixamorig_LeftHand")
	left_hand = skeleton.get_bone_pose(left_hand_id)
	
	right_hand_id = skeleton.find_bone("mixamorig_RightHand")
	right_hand = skeleton.get_bone_pose(right_hand_id)	
	
	left_ik = $'RootNode/Skeleton3D/LeftArmIKTarget'
	right_ik = $'RootNode/Skeleton3D/RightArmIKTarget'
	
	left_forearm_id = skeleton.find_bone("mixamorig_LeftForeArm")
	right_forearm_id = skeleton.find_bone("mixamorig_RightForeArm")	
	
	skeleton.set_bone_pose_rotation(left_forearm_id, Quaternion(0, -1, 0, 1))
	skeleton.set_bone_pose_rotation(right_forearm_id, Quaternion(0, 1, 0, 1))	
	
	head_id = skeleton.find_bone("mixamorig_Head")
	head = skeleton.get_bone_global_pose(head_id)
	
	head_marker = $'RootNode/Skeleton3D/Eyes'

	left_shoulder_id = skeleton.find_bone("mixamorig_LeftShoulder")
	right_shoulder_id = skeleton.find_bone("mixamorig_RightShoulder")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_pressed("pull_left_arm"):
		set_left_hand_position(skeleton.get_bone_global_pose(left_shoulder_id).origin)
	pass	
	


func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	mouse_position_3d = Vector3(position.x, position.y, 0)
	var mouse_position_left: Vector3 = Vector3(mouse_position_3d.x + hand_separation, mouse_position_3d.y, 0)
	var mouse_position_right: Vector3 = Vector3(mouse_position_3d.x - hand_separation, mouse_position_3d.y, 0)	
	print(mouse_position_3d)
	# TODO: revert these
	if  Input.is_action_pressed("hold_left"):
		left_ik.set_position(mouse_position_left)
	if  Input.is_action_pressed("hold_right"):		
		right_ik.set_position(mouse_position_right)	
		
#	var head_mouse_position_3d: Vector3 = Vector3(mouse_position_3d.x, mouse_position_3d.y, 20)
		
#	head = head.looking_at(head_mouse_position_3d, Vector3(0, 1, 0), true)
	head = head.looking_at(mouse_position_3d, Vector3(0, 1, 0), true)
#	head = head.orthonormalized()
#	head.basis = head.basis.rotated(head.basis.x, deg_to_rad(5))
	skeleton.set_bone_pose_rotation(head_id, head.basis)
	
func set_left_hand_position(position: Vector3):
	var mouse_position_left: Vector3 = Vector3(position.x, position.y, 0)
	left_ik.set_position(mouse_position_left)
	
func set_right_hand_position(position: Vector3):
	var mouse_position_right: Vector3 = Vector3(position.x, position.y, 0)	
	right_ik.set_position(mouse_position_right)	
