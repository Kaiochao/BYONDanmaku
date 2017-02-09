/*

	Just a test spawner that fires a regular stream of bullets at the player.

*/

obj/bullet_spawner
	icon_state = "oval"

	var
		_spawn_interval
		_next_spawn_time
		_color

	New(atom/loc, interval = 0, start_time = -1, color)
		_spawn_interval = interval
		_next_spawn_time = start_time
		_color = color

	Update()
		if(world.time >= _next_spawn_time)
			_next_spawn_time = world.time + _spawn_interval
			Spawn()

	proc
		// Called periodically according to the spawn interval.
		Spawn()

		// Fire a bullet with a certain speed at a certain angle.
		Fire(speed, angle)
			new/obj/bullet(src, speed * sin(angle), speed * cos(angle), _color)

		// Return a random player among the players in the world.
		GetRandomTarget()
			var list/players = new
			for(var/mob/player/player) players += player
			if(length(players)) return pick(players)

	homing
		Spawn()
			var mob/target = GetRandomTarget()
			if(target)
				new/obj/bullet/homing(src, target, 12, rgb(255, 255, 0), 30)

	multi_angle
		var
			_angle_interval

		New(atom/loc,
				interval = 5,
				start_time,
				color = "blue",
				angle_interval = 8
			)
			..()
			_angle_interval = angle_interval

		Spawn()
			for(var/da = 0 to 360 step _angle_interval)
				var angle = da + world.time
				angle += round(-angle, 360) + 180
				if(angle in 90 to 270)
					Fire(8, angle)

	random_spread
		var
			_spread
			_min_speed
			_max_speed

		New(atom/loc,
				interval = 2,
				start_time,
				color = rgb(0, 255, 0),
				spread = 60,
				min_speed = 6,
				max_speed = 12
			)
			..()
			_spread = spread
			_min_speed = min_speed
			_max_speed = max_speed

		Spawn()
			var mob/player/player = GetRandomTarget()
			if(player)
				var
					speed = randf(_min_speed, _max_speed)
					angle = randf(-_spread, _spread) + AngleTo(player)
				unless(angle == 1#IND)
					Fire(speed, angle)

		proc
			// Get the angle from the spawner to the center of another atom.
			AngleTo(atom/other)
				return atan2(other.CenterX() - CenterX(), other.CenterY() - CenterY())

	random_3_spread
		parent_type = .random_spread

		var
			_side_spread

		New(atom/loc,
				interval = 5,
				start_time,
				color = "red",
				spread = 5,
				min_speed,
				max_speed,
				side_spread = 15
			)
			..()
			_side_spread = side_spread

		Fire(speed, angle, main = TRUE)
			..()
			if(main)
				Fire(speed, angle - _side_spread, FALSE)
				Fire(speed, angle + _side_spread, FALSE)

	fast_3_spread
		parent_type = .random_3_spread

		New(atom/loc,
				interval = 15,
				start_time = 0,
				color = "yellow",
				spread = 0,
				min_speed = 16,
				max_speed = 16,
				side_spread = 4
			)
			..()
