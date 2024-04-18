extends Node3D

var sky_textures = [
	preload("res://skys/celestial_grid_16k.png"),
	preload("res://skys/constellation_figures_16k_gal.png"),
	# preload("res://skys/hiptyc_2020_16k_gal.png"),
	preload("res://skys/blank.png"),
	# Add more sky textures here
]

var current_sky_index = 0


func _input(event: InputEvent) -> void:

	# add event automaticly not working
	#if not InputMap.has_action("cycle_debug_menu"):
		## Create default input action if no user-defined override exists.
		## We can't do it in the editor plugin's activation code as it doesn't seem to work there.
		#InputMap.add_action("cycle_debug_menu")
		#var event := InputEventKey.new()
		#event.keycode = KEY_F3
		#InputMap.action_add_event("cycle_debug_menu", event)\
		
		
	if event.is_action_pressed("change_sky"):
		print("changing sky to:" + String.num(current_sky_index))
		var environment = get_world_3d().environment.sky

		if environment: # Check if it exists
			var my_new_mat = PanoramaSkyMaterial.new()
			my_new_mat.set_panorama(sky_textures[current_sky_index])
			environment.set_material(my_new_mat)
			
		current_sky_index = (current_sky_index + 1) % sky_textures.size()
	
	if event.is_action_pressed("take_screenshot"):
		#var image = get_viewport().get_texture().get_image()
		var date = Time.get_date_string_from_system().replace(".","")
		var time :String = Time.get_time_string_from_system().replace(":","")
		var rotation = get_node("Camera3D").get_global_transform().basis.get_euler() * 180 / PI
		#var rot_x = String.num(rotation_degrees.x)
		#var rot_y = String.num(rotation_degrees.y)
		var rot_y = rotation.y + 90 # need to add 90 for the sky offset
		print("X:%.4f" % rotation.x + " Y:%.4f" % rot_y)
		print("X: " + String.num(rotation.x) + " Y: " + String.num(rotation.y))
		#var screenshot_path = "user://screenshots/" + "screenshot_" + date + "-" + time + "_[" + "%.4f" % rotation_degrees.x + "_" + "%.4f" % rotation_degrees.y + "].png" # the path for our screenshot.

		# Save the image in PNG format (cleaner than JPG)
		#image.save_png(screenshot_path) 

