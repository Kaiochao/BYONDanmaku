/*

	"Danmaku" is a Japanese word that is used to describe what we call
	"shmups" or "bullet hells" or "curtain fire shooters".

	This is a basic world: 15x20 tiles of 32x32 pixels (640x480 total).
	One bullet spawner at the top fires bullets constantly toward the player.

*/

#include <kaiochao/shapes/shapes.dme>

var clock/GameClock

world
	maxx = 15
	maxy = 20
	fps = 60
	mob = /mob/player

	New()
		..()
		GameClock = new/clock/game_clock(
			is_paused = FALSE,
			subscribers = list(
				new/obj/bullet_spawner/multi_angle(locate(10, 20, 1)),
				new/obj/bullet_spawner/multi_angle(locate(6, 20, 1)),
				new/obj/bullet_spawner/random_3_spread(locate(3, 20, 1)),
				new/obj/bullet_spawner/fast_3_spread(locate(13, 20, 1)),
				new/obj/bullet_spawner/random_spread(locate(8, 20, 1))
			)
		)

atom
	// I hear this improves performance client-side
	// if no mouse interaction is necessary.
	mouse_opacity = FALSE

// Ugly green background turf.
turf
	icon_state = "rect"
	color = rgb(0, 64, 0)

// Display the CPU usage to all clients at the end of a tick.
clock/game_clock
	Tick()
		..()
		var t = "title=\"[world.name] ([round(world.cpu, 1)]%)\""
		for(var/client/c) if(c.key) winset(c, ":window", t)
