extends Node3D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("take_screenshot"):
		var image = get_viewport().get_texture().get_image()
	
		var date = Time.get_date_string_from_system().replace(".","_") 
		var time :String = Time.get_time_string_from_system().replace(":","")
		var screenshot_path = "user://screenshots/" + "screenshot_" + date+ "_" + time + ".png" # the path for our screenshot.

		# Save the image in PNG format (cleaner than JPG)
		image.save_png(screenshot_path) 

