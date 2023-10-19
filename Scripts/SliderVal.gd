extends RichTextLabel

func _on_h_slider_value_changed(value):
	self.text = "[center]Note Per Second: " + str(value)
