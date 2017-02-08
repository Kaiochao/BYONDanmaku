obj/bullet/homing
	var
		mob/_target
		_speed
		_homing_end_time

	New(atom/loc, mob/target, speed = 6, color = rgb(0, 255, 0), homing_duration = 30)
		..(loc, 0, 0, color)
		_target = target
		_speed = speed
		_homing_end_time = world.time + homing_duration
		var dx = target.CenterX() - loc.CenterX()
		var dy = target.CenterY() - loc.CenterY()
		var dist = hypot(dx, dy)
		unless(dist) src.loc = null

	Update()
		if(world.time < _homing_end_time)
			var dx = _target.CenterX() - CenterX()
			var dy = _target.CenterY() - CenterY()
			var dist = hypot(dx, dy)
			unless(dist)
				Hit(_target)
				return
			_velocity_x = dx / dist * _speed
			_velocity_y = dy / dist * _speed
		..()
