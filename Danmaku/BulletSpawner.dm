/*

	Just a test spawner that fires a regular stream of bullets at the player.

*/

obj/bullet_spawner
	icon_state = "oval"

	var
		_spawn_interval
		_next_spawn_time

	New(atom/loc, interval = 0, start_time = -1)
		_spawn_interval = interval
		_next_spawn_time = start_time

	Update()
		if(world.time >= _next_spawn_time)
			_next_spawn_time = world.time + _spawn_interval
			var mob/player/player = GetRandomTarget()
			if(player)
				var
					speed = randf(6, 12)
					spread = 60
					angle = randf(-spread, spread) + AngleTo(player)
				Fire(speed, angle)

	proc
		GetRandomTarget()
			var list/players = new
			for(var/mob/player/player) players += player
			if(length(players)) return pick(players)

		// Get the angle from the spawner to the center of another atom.
		AngleTo(atom/other)
			return atan2(other.CenterX() - CenterX(), other.CenterY() - CenterY())

		// Fire a bullet with a certain speed at a certain angle.
		Fire(speed, angle)
			unless(angle == 1#IND)
				new/obj/bullet(src, speed * sin(angle), speed * cos(angle))
