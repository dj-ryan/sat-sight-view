extends MultiMeshInstance3D

var star_count = 0

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
	print("Star Count: " + String.num(star_count))
	
	multimesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = $"../star".mesh.duplicate()
	multimesh.use_colors = true
	multimesh.instance_count = star_count
	
	for i in range(data["x"].size() - 1):
		# If there is a Error on this line.
		# Your CSV file has an extra line at the end of the file that gets added when opening in Excel
		# Open with notepad and scroll to the last row and delete it.
		multimesh.set_instance_color(i, Color(data["color"][i]))
		var calc_x = float(data["x"][i])
		var calc_y = float(data["y"][i])
		var calc_z = float(data["z"][i])
		
		var position = Vector3(calc_x, calc_z, -calc_y) # X Y Z
		# print(position)
		multimesh.set_instance_transform(i, Transform3D(Basis(), position))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
