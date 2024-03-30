extends Node3D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("take_screenshot"):
		var image = get_viewport().get_texture().get_image()
	
		var date = Time.get_date_string_from_system().replace(".","")
		date.replace("-","")
		var time :String = Time.get_time_string_from_system().replace(":","")
		var rotation_degrees = get_node("Camera3D").get_global_transform().basis.get_euler() * 180 / PI
		var rot_x = String.num(rotation_degrees.x)
		var rot_y = String.num(rotation_degrees.y)
		var screenshot_path = "user://screenshots/" + "screenshot_" + date + "-" + time + "_[" + rot_x + "_" + rot_y + "].png" # the path for our screenshot.

		# Save the image in PNG format (cleaner than JPG)
		image.save_png(screenshot_path) 

