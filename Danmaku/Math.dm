/*

	Convenient math functions.

	hypot(x, y) gets the hypotenuse of a triangle with side lengths x and y.

	atan2(x, y) gets the angle from (0, 0) to (x, y).
		Angles are in clockwise degrees east of north.

	lerp(a, b, t) gets the number that is t "percent" from a to b.

	randf(a, b) returns a uniform random float between a and b.
		(rand(a, b) only returns integers, or whole numbers.)

*/

proc
	hypot(x, y)
		return sqrt(x * x + y * y)

	atan2(x, y)
		unless(x || y) return 1#IND
		return x >= 0 ? arccos(y / hypot(x, y)) : -arccos(y / hypot(x, y))

	lerp(a, b, t)
		return a * (1 - t) + b * t

	randf(a, b)
		return lerp(a, b, rand())
