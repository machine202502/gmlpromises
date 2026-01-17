
/// TEST RESULTS

test_resolve = {
	name: "test_resolve",
	is_finished: false,
	expected: 23,
	received: undefined,
};
test_reject = {
	name: "test_reject",
	is_finished: false,
	expected: 64,
	received: undefined,
};
test_later_resolve = {
	name: "test_later_resolve",
	is_finished: false,
	expected: 80,
	received: undefined,
}
test_later_reject = {
	name: "test_later_reject",
	is_finished: false,
	expected: 25,
	received: undefined,
}
test_uncaught_handler = {
	name: "test_uncaught_handler",
	is_finished: false,
}
test_reject_after_throw = {
	name: "test_reject_after_throw",
	is_finished: false,
	expected: 68,
	received: undefined,
}
test_finally_after_resolve = {
	name: "test_finally_after_resolve",
	expected_a: 771,
	received_a: undefined,
	expected_b: 518,
	received_b: undefined,
}
test_finally_after_reject = {
	name: "test_finally_after_reject",
	expected_a: 227,
	received_a: undefined,
	expected_b: 632,
	received_b: undefined,
}

/// TESTS

function run_test_resolve() {
	
	future_resolve(23).on_then(function(_value) {
		obj_future_test.test_resolve.is_finished = true;
		obj_future_test.test_resolve.received = _value;
	});
	
}

function run_test_reject() {
	
	future_reject(64).on_catch(function(_value) {
		obj_future_test.test_reject.is_finished = true;
		obj_future_test.test_reject.received = _value;
	});
	
}

function run_test_later_resolve() {
	
	var _future = future_resolve(80);
	var _context = {
		future: _future,	
	};
	var _timesource = time_source_create(time_source_game, 100, time_source_units_frames, method(_context, function() {
		time_source_destroy(self.timesource);
			
		self.future.on_then(function(_value) {
			obj_future_test.test_later_resolve.is_finished = true;
			obj_future_test.test_later_resolve.received = _value;
		});
	}));
		
	_context.timesource = _timesource;
	time_source_start(_timesource);
	
}

function run_test_later_reject() {
	
	var _future = future_reject(25);
	var _context = {
		future: _future,	
	};
	var _timesource = time_source_create(time_source_game, 100, time_source_units_frames, method(_context, function() {
		time_source_destroy(self.timesource);
			
		self.future.on_catch(function(_value) {
			obj_future_test.test_later_reject.is_finished = true;
			obj_future_test.test_later_reject.received = _value;
		});
	}));
		
	_context.timesource = _timesource;
	time_source_start(_timesource);
	
}

function run_test_uncaught_handler() {
	
	var _error = function() {
		obj_future_test.test_uncaught_handler.is_finished = true;
	}
	var _future = future_reject(_error);
	
}

function run_test_reject_after_throw() {
	
	var _future = future(function() {
		throw 68;
	});
	
	_future.on_catch(function(_value) {
		obj_future_test.test_reject_after_throw.is_finished = true;
		obj_future_test.test_reject_after_throw.received = _value;
	});
	
}

function run_test_finally_after_resolve() {
	
	future_resolve(100)
		.on_then(function(_value) {
			obj_future_test.test_finally_after_resolve.received_a = _value * 2;
		})
		.on_finally(function() {
			obj_future_test.test_finally_after_resolve.received_a = 36;
			return 2234;
		})
		.on_then(function(_value) {
			obj_future_test.test_finally_after_resolve.received_a = _value;
		})
		.on_finally(function() {
			obj_future_test.test_finally_after_resolve.received_a = 771;
			return 2234;
		});
		
	future_resolve(518)
		.on_finally(function() {
			obj_future_test.test_finally_after_resolve.received_b = 100;
			return 2234;
		})
		.on_finally(function() {
			obj_future_test.test_finally_after_resolve.received_b = 150;
			return 2234;
		})
		.on_then(function(_value) {
			obj_future_test.test_finally_after_resolve.received_b = _value * 2;
			return _value;
		})
		.on_finally(function() {
			obj_future_test.test_finally_after_resolve.received_b = 100;
			return 2234;
		})
		.on_then(function(_value) {
			obj_future_test.test_finally_after_resolve.received_b = _value;
		})
}

function run_test_finally_after_reject() {
 	
	future_reject(100)
		.on_then(function(_value) {
			obj_future_test.test_finally_after_reject.received_a = _value * 2;
		})
		.on_finally(function() {
			obj_future_test.test_finally_after_reject.received_a = 36;
			return 2234;
		})
		.on_then(function(_value) {
			obj_future_test.test_finally_after_reject.received_a = _value;
		})
		.on_finally(function() {
			obj_future_test.test_finally_after_reject.received_a = 227;
			return 2234; 
		});
		
	future_reject(632)
		.on_finally(function() {
			obj_future_test.test_finally_after_reject.received_b = 100;
			return 2234;
		})
		.on_finally(function() {
			obj_future_test.test_finally_after_reject.received_b = 150;
			return 2234;
		})
		.on_then(function(_value) {
			obj_future_test.test_finally_after_reject.received_b = _value * 2;
			return _value;
		})
		.on_catch(function(_value) {
			obj_future_test.test_finally_after_reject.received_b = _value * 10;
			throw _value;
		})
		.on_finally(function() {
			obj_future_test.test_finally_after_reject.received_b = 100;
			return 2234;
		})
		.on_then(function(_value) {
			obj_future_test.test_finally_after_reject.received_b = _value * 3;
		})
		.on_catch(function(_value) {
			obj_future_test.test_finally_after_reject.received_b = _value;
		});
}

function run_test() {
	
}

/// RUN

future_set_uncaught_handler(function(_maybe_callable) {
	show_debug_message("");
	show_debug_message("uncaught_handling");
	show_debug_message(_maybe_callable);
	
	if (is_method(_maybe_callable)) {
		_maybe_callable();
	}
});

run_test_resolve();
run_test_reject();
run_test_later_resolve();
run_test_later_reject();
run_test_uncaught_handler();
run_test_reject_after_throw();
run_test_finally_after_resolve();
run_test_finally_after_reject();

alarm_set(0, game_get_speed(gamespeed_fps) * 5);
