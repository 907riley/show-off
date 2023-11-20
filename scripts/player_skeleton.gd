extends Skeleton3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var bones: Array = ["Physical Bone mixamorig_LeftUpLeg"]
	physical_bones_start_simulation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
