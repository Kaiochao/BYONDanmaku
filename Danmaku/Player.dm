/*

	The player moves with WASD.
	Hold shift to move slower.

*/

client
	fps = 60

	// Disable default movement commands.
	Move()

mob/player
	icon_state = "oval"
	color = "aqua"
	transform = matrix(8/32, 0, -12, 0, 8/32, -12)
	bound_width = 8
	bound_height = 8

	var
		move_speed = 16

	Login()
		loc = locate(8, 1, 1)
		step_x = loc.CenterX() - CenterX()
		step_y = loc.CenterY() - CenterY()
		GameClock.Subscribe(src)
		..()

	Logout()
		GameClock.Unsubscribe(src)
		..()

	// Get hit when overlapped by a bullet.
	Crossed(atom/movable/m)
		if(istype(m, /obj/bullet))
			var obj/bullet/b = m
			b.Hit(src)

	Update(clock/clock)
		// Speed factor: multiplies the movement input vector to determine
		// speed over time.
		var s = move_speed * clock.tick_lag

		if(s)
			var
				// input_x is 0, -1, or +1 depending on the buttons pressed.
				input_x = client.IsButtonPressed("d") - client.IsButtonPressed("a")

				// same as above.
				input_y = client.IsButtonPressed("w") - client.IsButtonPressed("s")

				// slow-down button
				input_f = client.IsButtonPressed("shift")

			// Apply slow-down if appropriate.
			if(input_f)
				s *= 1/2

			// If moving, move.
			if(input_x || input_y)
				var
					vx = input_x * s
					vy = input_y * s

				// Try moving diagonally, otherwise try moving horizontally then vertically,
				// otherwise try moving vertically then horizontally.
				unless(PixelMove(vx, vy))
					if(PixelMove(vx, 0))
						PixelMove(0, vy)
					else
						PixelMove(0, vy)
						PixelMove(vx, 0)
