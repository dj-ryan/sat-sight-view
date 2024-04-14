extends Node3D

var sky_textures = [
	preload("res://skys/celestial_grid_16k.png"),
	preload("res://skys/constellation_figures_16k.png"),
	preload("res://skys/hiptyc_2020_16k_gal.png"),
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
		current_sky_index = (current_sky_index + 1) % sky_textures.size()
		var environment = get_world_3d().environment.sky

		if environment: # Check if it exists
			var my_new_mat = PanoramaSkyMaterial.new()
			my_new_mat.set_panorama(sky_textures[current_sky_index])
			environment.set_material(my_new_mat)
	
	if event.is_action_pressed("take_screenshot"):
		#var image = get_viewport().get_texture().get_image()
		var date = Time.get_date_string_from_system().replace(".","")
		var time :String = Time.get_time_string_from_system().replace(":","")
		var rotation_degrees = get_node("Camera3D").get_global_transform().basis.get_euler() * 180 / PI
		var rot_x = String.num(rotation_degrees.x)
		var rot_y = String.num(rotation_degrees.y)
		print("X: " + rot_x + " Y:" + rot_y)
		#var screenshot_path = "user://screenshots/" + "screenshot_" + date + "-" + time + "_[" + rot_x + "_" + rot_y + "].png" # the path for our screenshot.

		# Save the image in PNG format (cleaner than JPG)
		#image.save_png(screenshot_path) 

