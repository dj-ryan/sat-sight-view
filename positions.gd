extends MultiMeshInstance3D

const HOW_MANY : int = 9098 #short 997

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.open("res://data/star_formated_raw.csv", FileAccess.READ)

	var headers = file.get_csv_line(",")  # Get column names
	var data = {}  # A dictionary to store column data

	# Initialize empty arrays in the dictionary
	for header in headers:
		data[header] = []

	# Read data and populate arrays
	while not file.eof_reached():
		var values = file.get_csv_line(",")
		for i in range(values.size()):
			data[headers[i]].append(values[i])

	file.close()

	# Example usage:
	# print(data["GLON"])  # Prints the contents of the 'col1' array
	
	# var vertices = PackedVector3Array()

	multimesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	#multimesh.mesh = $"../MultiMeshInstance3D".mesh.duplicate()
	multimesh.mesh = $"../star".mesh.duplicate()
	multimesh.instance_count = HOW_MANY

	for i in range(data["GLON"].size()-1):
		#print(data["GLON"][i])
		var vec = spherical_to_cartesian(10,data["GLON"][i], data["GLAT"][i])
		print(vec)
		multimesh.set_instance_transform(i, Transform3D(Basis(), vec))
		# vertices.append(vec)
	
	
func spherical_to_cartesian(r, lon_phi, lat_theta):
	var radius = float(r)
	var theta = deg_to_rad(float(lat_theta))
	var phi = deg_to_rad(float(lon_phi))
	#var theta = float(lat_theta)
	#var phi = float(lon_phi)
	
	var x = r * cos(theta) * cos(phi)
	var y = r * cos(theta) * sin(phi)
	var z = r * sin(theta)
	return Vector3(x, y, z)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
