
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
test_uncaught_handler_2 = {
	name: "test_uncaught_handler_2",
	is_finished: false,
}
test_uncaught_handler_3 = {
	name: "test_uncaught_handler_3",
	is_finished: false,
}
test_uncaught_handler_4 = {
	name: "test_uncaught_handler_4",
	expected: 3,
	received: 0,
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
test_later_dobule_resolve = {
	name: "test_later_dobule_resolve",
	is_finished: false,
	expected: 120,
	received: 0,
}
test_later_dobule_reject = {
	name: "test_later_dobule_reject",
	is_finished: false,
	expected: 240,
	received: 0,
}
test_correct_chain = {
	name: "test_correct_chain",
	is_finished: false,
	on_1_expected: "begin",
	on_1_received: undefined,
	on_1_received_later: undefined,
	on_2_expected: "on_2_expected",
	on_2_received: undefined,
	on_2_received_later: undefined,
	on_3_expected: "begin and end",
	on_3_received: undefined,
	on_3_received_later: undefined,
	on_4_expected: "again",
	on_4_received: undefined,
	on_4_received_later: undefined,
	on_5_expected: undefined,
	on_5_received: undefined,
	on_5_received_later: undefined,
	on_6_expected: "on_6_expected",
	on_6_received: undefined,
	on_6_received_later: undefined,
	on_7_expected: ">>is error",
	on_7_received: undefined,
	on_7_received_later: undefined,
	on_8_expected: "error handled",
	on_8_received: undefined,
	on_8_received_later: undefined,
	on_9_expected: "timeout",
	on_9_received: undefined,
	on_9_received_later: undefined,
	on_10_expected: ">>is reject",
	on_10_received: undefined,
	on_10_received_later: undefined,
	on_11_expected: true,
	on_11_received: undefined,
	on_11_received_later: undefined,
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

function run_test_uncaught_handler_2() {
	
	var _error = function() {
		obj_future_test.test_uncaught_handler_2.is_finished = true;
	}
	var _future = future_reject(_error)
		.on_then(functor_void)
		.on_finally(functor_void)
	
}

function run_test_uncaught_handler_3() {
	
	var _error = function() {
		obj_future_test.test_uncaught_handler_3.is_finished = true;
	}
	var _future = future_reject(_error)
		.on_then(functor_void)
		.on_finally(functor_void)
		.on_catch(functor_throw);
	
}

function run_test_uncaught_handler_4() {
	
	var _error = function() {
		obj_future_test.test_uncaught_handler_4.received += 1;
	}
	var _future = future_reject(_error);
	
	_future
		.on_then(functor_void)
		.on_catch(functor_void);
	
	_future
		.on_then(functor_void);
	
	_future
		.on_finally(functor_void);
	
	var _context = {
		future: _future,	
	};
	var _timesource = time_source_create(time_source_game, 100, time_source_units_frames, method(_context, function() {
		time_source_destroy(self.timesource);
		
		self.future.on_finally(functor_void);
	}));
		
	_context.timesource = _timesource;
	time_source_start(_timesource);
	
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

function run_test_later_dobule_resolve() {
	
	var _future = future_resolve(60);
	var _context_a = {
		future: _future,	
	};
	var _timesource_a = time_source_create(time_source_game, 100, time_source_units_frames, method(_context_a, function() {
		time_source_destroy(self.timesource);
			
		self.future.on_then(function(_value) {
			obj_future_test.test_later_dobule_resolve.received += _value;
		});
	}));
	
	_context_a.timesource = _timesource_a;
	time_source_start(_timesource_a);
	
	var _context_b = {
		future: _future,	
	};
	var _timesource_b = time_source_create(time_source_game, 180, time_source_units_frames, method(_context_b, function() {
		time_source_destroy(self.timesource);
			
		self.future.on_then(function(_value) {
			obj_future_test.test_later_dobule_resolve.is_finished = true;
			obj_future_test.test_later_dobule_resolve.received += _value;
		});
	}));
	
	_context_b.timesource = _timesource_b;
	time_source_start(_timesource_b);
	
}

function run_test_later_dobule_reject() {
	
	var _future = future_reject(120);
	var _context_a = {
		future: _future,	
	};
	var _timesource_a = time_source_create(time_source_game, 100, time_source_units_frames, method(_context_a, function() {
		time_source_destroy(self.timesource);
			
		self.future.on_catch(function(_value) {
			obj_future_test.test_later_dobule_reject.received += _value;
		});
	}));
	
	_context_a.timesource = _timesource_a;
	time_source_start(_timesource_a);
	
	var _context_b = {
		future: _future,	
	};
	var _timesource_b = time_source_create(time_source_game, 180, time_source_units_frames, method(_context_b, function() {
		time_source_destroy(self.timesource);
			
		self.future.on_catch(function(_value) {
			obj_future_test.test_later_dobule_reject.is_finished = true;
			obj_future_test.test_later_dobule_reject.received += _value;
		});
	}));
	
	_context_b.timesource = _timesource_b;
	time_source_start(_timesource_b);
	
}

function run_test_correct_chain() {
	
	var _f1 = future_resolve("begin");
	
	var _f2 = _f1.on_then(function(_value) {
		obj_future_test.test_correct_chain.on_1_received = _value;
		
		return (_value + " and end");
	});
	
	var _f3 = _f2.on_finally(function() {
		obj_future_test.test_correct_chain.on_2_received = "on_2_expected";
	}); 
	
	var _f4 = _f3.on_then(function(_value) {
		obj_future_test.test_correct_chain.on_3_received = _value;
		
		return "again";
	});
	
	var _f5 = _f4.on_then(function(_value) {
		obj_future_test.test_correct_chain.on_4_received = _value;
		
		throw ">>is error";
	});
	
	var _f6 = _f5.on_then(function(_value) {
		obj_future_test.test_correct_chain.on_5_received = "not working";
	});
	
	var _f7 = _f6.on_finally(function(_value) {
		obj_future_test.test_correct_chain.on_6_received = "on_6_expected";
	});
	
	var _f8 = _f7.on_catch(function(_value) {
		obj_future_test.test_correct_chain.on_7_received = _value;
		
		return "error handled";
	});
	
	var _f9 = _f8.on_then(function(_value) {
		obj_future_test.test_correct_chain.on_8_received = _value;
		
		return "timeout";
	});
	
	var _f10_timeout = _f9.on_then(function(_value) {
		
		var _context = {
			value: _value,	
		};
		var _timeout_future = future(method(_context, function(_resolve) {
			var _value = self.value;
			var _context = {
				value: self.value,
				resolve: _resolve,
			};
			var _timesource = time_source_create(time_source_game, 100, time_source_units_frames, method(_context, function() {
				time_source_destroy(self.timesource);
				self.resolve(self.value);
			}));
	
			_context.timesource = _timesource;
			time_source_start(_timesource);
			
		}));
		
		return _timeout_future;
		
	});
	
	var _f10 = _f10_timeout.on_then(function(_value) {
		obj_future_test.test_correct_chain.on_9_received = _value;
		
		return future_reject(">>is reject");
	});
	
	var _f11 = _f10.on_catch(function(_value) {
		obj_future_test.test_correct_chain.on_10_received = _value;
		
		throw future_resolve();
	});
	
	var _f12 = _f11.on_catch(function(_value) {
		obj_future_test.test_correct_chain.on_11_received = is_future(_value);
	});
	
	var _futures = {
		f1: _f1,
		f2: _f2,
		f3: _f3,
		f4: _f4,
		f5: _f5,
		f6: _f6,
		f7: _f7,
		f8: _f8,
		f9: _f9,
		f10: _f10,
		f11: _f11,
	}
	
	var _context = {
		futures: _futures,
	};
	var _timesource = time_source_create(time_source_game, 200, time_source_units_frames, method(_context, function() {
		time_source_destroy(self.timesource);
		
		self.futures.f1.on_then(function(_value) {
			obj_future_test.test_correct_chain.on_1_received_later = _value;
		})
		self.futures.f2.on_finally(function() {
			obj_future_test.test_correct_chain.on_2_received_later = "on_2_expected";
		})
		self.futures.f3.on_then(function(_value) {
			obj_future_test.test_correct_chain.on_3_received_later = _value;
		})
		self.futures.f4.on_then(function(_value) {
			obj_future_test.test_correct_chain.on_4_received_later = _value;
		})
		self.futures.f5.on_then(function(_value) {
			obj_future_test.test_correct_chain.on_5_received_later = _value;
		})
		self.futures.f6.on_finally(function() {
			obj_future_test.test_correct_chain.on_6_received_later = "on_6_expected";
		})
		self.futures.f7.on_catch(function(_value) {
			obj_future_test.test_correct_chain.on_7_received_later = _value;
		})
		self.futures.f8.on_then(function(_value) {
			obj_future_test.test_correct_chain.on_8_received_later = _value;
		})
		self.futures.f9.on_then(function(_value) {
			obj_future_test.test_correct_chain.on_9_received_later = _value;
		})
		self.futures.f10.on_catch(function(_value) {
			obj_future_test.test_correct_chain.on_10_received_later = _value;
		})
		self.futures.f11.on_catch(function(_value) {
			obj_future_test.test_correct_chain.on_11_received_later = is_future(_value);
		});
		
	}));
	
	_context.timesource = _timesource;
	time_source_start(_timesource);
	
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
run_test_uncaught_handler_2();
run_test_uncaught_handler_3();
run_test_uncaught_handler_4();
run_test_reject_after_throw();
run_test_finally_after_resolve();
run_test_finally_after_reject();
run_test_later_dobule_resolve();
run_test_later_dobule_reject();
run_test_correct_chain();

var _secs = 10;
alarm_set(0, game_get_speed(gamespeed_fps) * _secs);
alarm_set(1, game_get_speed(gamespeed_fps) * _secs + 5);
