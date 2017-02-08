/*

	This file (along with Buttons.dms) allows for a client's keyboard state
	to be tracked. There are procs you can override to add functionality when any
	button is pressed or released, and there is a proc you can call to check if
	a certain button is being pressed or not.

	client
		IsButtonPressed(button)
			Returns:
				TRUE if button is currently pressed.
				FALSE if button is not currently pressed.

		ButtonPressed(button)
			Called when a button is pressed.

			Args:
				button: Name of the button pressed.

			Default action:
				Call mob.ButtonPressed(button).

		ButtonReleased(button)
			Called when a button is released.

			Args:
				button: Name of the button released.

			Default action:
				Call mob.ButtonPressed(button).

*/

client
	var
		list
			buttons_pressed

	New()
		buttons_pressed = new
		. = ..()

	verb
		ButtonPress(button as text)
			set name = ".button press", instant = TRUE
			button = lowertext(button)
			unless(button in buttons_pressed)
				buttons_pressed += button
				ButtonPressed(button)

		ButtonRelease(button as text)
			set name = ".button release", instant = TRUE
			button = lowertext(button)
			if(button in buttons_pressed)
				buttons_pressed -= button
				ButtonReleased(button)

	proc
		IsButtonPressed(button) return lowertext(button) in buttons_pressed
		ButtonPressed(button) mob.ButtonPressed(button)
		ButtonReleased(button) mob.ButtonReleased(button)

mob
	proc
		ButtonPressed(button)
		ButtonReleased(button)
