extends Node3D

@onready var skeleton : Skeleton3D = $'Skeleton3D'

var mouse_position_3d : Vector3

var left_hand : Transform3D
var left_hand_id : int

var right_hand : Transform3D
var right_hand_id : int 

var left_ik : Marker3D
var right_ik : Marker3D

@export var amount : float = 1
@export var persistent : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	left_hand_id = skeleton.find_bone("mixamorig_LeftHand")
	left_hand = skeleton.get_bone_pose(left_hand_id)
	
	left_hand_id = skeleton.find_bone("mixamorig_RightHand")
	right_hand = skeleton.get_bone_pose(right_hand_id)	
	
	left_ik = $'Skeleton3D/LeftArmIKTarget'
	right_ik = $'Skeleton3D/RightArmIKTarget'
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	track_mouse_3d()
	var mouse_position_no_z : Vector3 = mouse_position_3d
	mouse_position_no_z.z = 0 
	left_ik.set_position(mouse_position_no_z)
#	left_ik.translate(mouse_position_no_z)
	right_ik.set_position(mouse_position_no_z)	
#	left_hand = left_hand.translated(mouse_position_3d)
#	left_hand = left_hand.rotated(Vector3(0, 1, 0), 0.1 * delta)
#	skeleton.set_bone_pose_position(left_hand_id, mouse_position_3d)
#	skeleton.set_bone_global_pose_override(left_hand_id, left_hand, amount, persistent)
	
	
func track_mouse_3d():
	var viewport : Viewport = get_viewport()
	var mouse_position : Vector2 = viewport.get_mouse_position()
	print("normal mouse", mouse_position)
	var camera : Camera3D = viewport.get_camera_3d()
	
	var origin : Vector3 = camera.project_ray_origin(mouse_position)
	origin.z = 0
	var direction : Vector3 = camera.project_ray_normal(mouse_position)
	direction.z = 0
	
	var ray_length : float = camera.far
	var end : Vector3 = origin + (direction * ray_length)
	end.z = 0
	
	var space_state : PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var query : PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(origin, end)
	var result : Dictionary = space_state.intersect_ray(query)
	
	mouse_position_3d = result.get("position", end)
	print(mouse_position_3d)
