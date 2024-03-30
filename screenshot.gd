extends Button


#var screenshot_path = "user://screenshots/"

func _on_Button_pressed():
	
	$"../screenshot_button".hide()
	var image = get_viewport().get_texture().get_image()
	$"../screenshot_button".show()

	#var _time = Time.get_datetime_string_from_system()
	#var filename = "user://Screenshot-{0}.png".format({"0":_time})
	
	var date = Time.get_date_string_from_system().replace(".","_") 
	var time :String = Time.get_time_string_from_system().replace(":","")
	var screenshot_path = "user://screenshots/" + "screenshot_" + date+ "_" + time + ".png" # the path for our screenshot.

	# Save the image in PNG format (cleaner than JPG)
	image.save_png(screenshot_path) 
