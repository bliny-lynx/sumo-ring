extends ColorRect

func fade_in():
    var t = get_tree().create_tween()
    t.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.5)

func fade_out():
    var t = get_tree().create_tween()
    t.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.5)
