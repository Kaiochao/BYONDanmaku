/*

	This is a simple circular bullet that moves at a constant velocity.

	As often in danmaku, the bullets appear larger than their actual hitbox.

*/

obj/bullet
	icon_state = "oval"
	color = "red"
	transform = matrix(24/32, 0, -12, 0, 24/32, -12)
	bound_width = 8
	bound_height = 8
	overlays = list(.center)
	blend_mode = BLEND_ADD

	// This gives the white center to the bullet.
	center
		parent_type = /obj
		icon_state = "oval"
		color = "white"
		appearance_flags = RESET_COLOR
		transform = matrix(2/3, 0, 0, 0, 2/3, 0)
		layer = FLOAT_LAYER

	var
		_velocity_x
		_velocity_y

	New(atom/loc, velocity_x, velocity_y, color = "red")
		src.color = color
		_velocity_x = velocity_x
		_velocity_y = velocity_y

		// Convenience: when given a movable atom as an initial loc,
		// center on that atom instead of going inside it.
		if(istype(loc, /atom/movable))
			var atom/movable/m = loc
			src.loc = m.loc
			step_x = m.CenterX() - CenterX()
			step_y = m.CenterY() - CenterY()

		// Start updating over time.
		GameClock.Subscribe(src)

	Crossed(atom/movable/m)
		// When a mob overlaps this, hit the mob.
		// The mob has a similar Crossed() for when this overlaps the mob.
		if(ismob(m))
			Hit(m)

	Update(clock/clock)
		var dt = clock.tick_lag

		// Unless movement succeeds, the bullet is destroyed.
		unless(PixelMove(_velocity_x * dt, _velocity_y * dt))
			Destroy()

	proc
		Destroy()
			loc = null
			GameClock.Unsubscribe(src)

		Hit(mob/m)
			Destroy()
