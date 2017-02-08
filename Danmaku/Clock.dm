/*

	A clock ticks over time.

	Any datum that subscribes to a clock gets its Update() proc called
	whenever the clock ticks.

	This is useful for things that happen over time, such as:
	* Player input handling. This allows diagonal movement with 2 keys pressed.
	* Physics simulations. Particularly, integrating velocity into position...
		Basically, making bullets move over time.

*/

datum
	proc
		Update(clock/clock)

clock
	var
		_is_paused
		_interval
		_time
		tick_lag
		list/_subscribers
		_is_started

	New(
		is_paused = TRUE,
		interval = world.tick_lag,
		start_time = 0,
		list/subscribers = new
		)
		_is_paused = is_paused
		_interval = tick_lag = interval
		_time = start_time
		_subscribers = subscribers
		_is_started = FALSE

	proc
		Subscribe(datum/s)		unless(s in _subscribers)	_subscribers += s
		Unsubscribe(datum/s)	if(s in _subscribers)			_subscribers -= s

		Start()
			set waitfor = FALSE, background = TRUE
			unless(_is_started)
				_is_started = TRUE
				for()
					Tick()
					sleep _interval

		Tick()
			set waitfor = FALSE, background = TRUE
			for(var/datum/s in _subscribers) s.Update(src)
