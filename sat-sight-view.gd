extends Node3D

var sky_textures = [
	preload("res://assets/celestial_grid_16k.png"),
	preload("res://assets/constellation_figures_16k_gal.png"),
	preload("res://assets/blank.png"),
	# Add more sky textures here
]

var camera_positions = []
var camera_position_index = 0
var current_sky_index = 0

var keep_scanning = false


# Called when the node enters the scene tree for the first time.
func _ready():
	load_camera_positions()
	
func _input(event: InputEvent) -> void:

	if event.is_action_pressed("ChangeSky"):
		print("Changing sky to:" + String.num(current_sky_index))
		var environment = get_world_3d().environment.sky

		if environment: # Check if it exists
			var my_new_mat = PanoramaSkyMaterial.new()
			my_new_mat.set_panorama(sky_textures[current_sky_index])
			environment.set_material(my_new_mat)
			
		current_sky_index = (current_sky_index + 1) % sky_textures.size()
	
	if event.is_action_pressed("TakeScreenshot"):
		capture_screenshot()
		
	if event.is_action_pressed("BeginScan"):
		keep_scanning = true
		scan_sky()
		
	if event.is_action_pressed("EndScan"):
		keep_scanning = false
		
func load_camera_positions():
	var file = FileAccess.open("res://data/camera_pos.csv", FileAccess.READ)
	var _headers = file.get_csv_line(",")  # Get column names
	while not file.eof_reached():
		#var line = file.get_line().split(",")
		var line = file.get_csv_line(",")
		#print(line)
		camera_positions.append(Vector3(float(line[0]), float(line[1]), float(line[2])))
	file.close()

func scan_sky():
	while camera_position_index < camera_positions.size() && keep_scanning == true:
	#if current_position_index < camera_positions.size():
		move_camera(camera_positions[camera_position_index])
		#yield(get_tree().create_timer(0.5), "timeout")  # Slight delay for camera to settle
		await get_tree().create_timer(0.1).timeout
		capture_screenshot()
		await get_tree().create_timer(0.1).timeout
		#print("[" + String.num(camera_position_index) + "] - (" + String.num(camera_positions[camera_position_index][0]) + "," + String.num(camera_positions[camera_position_index][1]) + "," + String.num(camera_positions[camera_position_index][2]) + ")")
		# printraw("[" +  String.num(camera_position_index) + "] - ")
		camera_position_index += 1

func move_camera(pos_data):
	var camera = $"Camera3D"
	camera.rotate_y(deg_to_rad(pos_data[1]))
	camera.rotate_object_local(Vector3(1,0,0), deg_to_rad(pos_data[0]))



func capture_screenshot(): 
	var image = get_viewport().get_texture().get_image()
	var rotation = get_node("Camera3D").get_global_transform().basis.get_euler() * 180 / PI
	var phi = rotation.y # rotation around the y axis
	var lambda = rotation.x # rotation around the x axis
	
	# convert to 360 degrees
	if phi < 0:
		phi += 360
	# shfit 90 degrees
	if phi < 270:
		phi += 90
	else:
		phi  -= 270
	print("[" +  String.num(camera_position_index) + "] - lambda: %.4f" % lambda + " phi: %.4f" % phi)
	var screenshot_path = "user://screenshots/" + "screenshot_[" + "%.4f" % lambda + "_" + "%.4f" % phi + "].png" # the path for our screenshot.
	# Save the image in PNG format (cleaner than JPG)
	image.save_png(screenshot_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
