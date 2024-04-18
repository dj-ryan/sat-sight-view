extends MultiMeshInstance3D

var star_count = 0 # : int = 9096 #short 997

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.open("res://data/star_pos.csv", FileAccess.READ)

	var headers = file.get_csv_line(",")  # Get column names
	var data = {}  # A dictionary to store column data

	# Initialize empty arrays in the dictionary
	for header in headers:
		data[header] = []

	# Read data and populate arrays
	while not file.eof_reached():
		var values = file.get_csv_line(",")
		star_count += 1
		for i in range(values.size()):
			# print("hit: " + String.num(i))
			data[headers[i]].append(values[i])

	file.close()

	multimesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = $"../star".mesh.duplicate()
	multimesh.use_colors = true
	print("Star Count: " + String.num(star_count))
	multimesh.instance_count = star_count
	
	# create sphere mesh instead of duplicating one, not working
	#var sphere_mesh = SphereMesh.new()
	#var material = StandardMaterial3D.new()
	#material.vertex_color_use_as_albedo = true
	#material.albedo_color = Color.WHITE
	#sphere_mesh.material = material

	for i in range(data["COLOR"].size() - 1): # dont iterate
		multimesh.set_instance_color(i, Color(data["COLOR"][i]))
		var calc_x = float(data["calc_x"][i])
		var calc_y = float(data["calc_y"][i])
		var calc_z = float(data["calc_z"][i])
		
		var position = Vector3(calc_x, calc_z, -calc_y) # X Y Z
		multimesh.set_instance_transform(i, Transform3D(Basis(), position))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
