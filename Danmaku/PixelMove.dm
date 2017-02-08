/*

	Enables movement by non-integer pixels along the x and y axis,
	with pixel-precise box-casted collision detection from the built-in
	pixel movement system.

	Basically allows bullets to move at any speed and any angle.

*/

atom/movable
	var
		sub_step_x = 0
		sub_step_y = 0

	proc
		PixelMove(x, y)
			sub_step_x += x
			sub_step_y += y
			var
				whole_x = round(sub_step_x, 1)
				whole_y = round(sub_step_y, 1)
			sub_step_x -= whole_x
			sub_step_y -= whole_y
			if(whole_x || whole_y)
				step_size = max(abs(whole_x), abs(whole_y))
				return Move(loc, dir, step_x + whole_x, step_y + whole_y)
			return max(abs(x), abs(y))
