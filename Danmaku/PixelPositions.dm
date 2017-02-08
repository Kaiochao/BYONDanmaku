/*

	Convenient procs for working with pixel movement.

*/
atom
	proc
		Width() return TILE_WIDTH
		Height() return TILE_HEIGHT
		LowerX() return 1 + (x - 1) * TILE_WIDTH
		LowerY() return 1 + (y - 1) * TILE_HEIGHT
		CenterX() return LowerX() + Width() / 2
		CenterY() return LowerY() + Height() / 2

	movable
		Width() return bound_width
		Height() return bound_height
		LowerX() return ..() + bound_x + step_x
		LowerY() return ..() + bound_y + step_y
