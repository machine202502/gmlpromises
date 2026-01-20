
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
test_resolvers = {
	name: "test_resolvers",
	callable_resolve: undefined,
	callable_reject: undefined,
	resolve_expected: 1452,
	resolve_received: undefined,
	reject_expected: 247,
	reject_received: undefined,
}
test_resolvers_2 = {
	name: "test_resolvers_2",
	callable_resolve: undefined,
	callable_reject: undefined,
	resolve_expected: 14528,
	resolve_received: undefined,
	reject_expected: 2478,
	reject_received: undefined,
}
test_future_all = {
	name: "test_future_all",
	finished_a: false,
	finished_b: false,
	finished_c: false,
	finished_c2: false,
	c_info: undefined,
	c2_info: undefined,
}
test_future_any = {
	name: "test_future_any",
	finished_a: false,
	finished_b: false,
	finished_c: false,
	finished_d: false,
	finished_e1: false,
	finished_e1_info: undefined,
	finished_e2: false,
	finished_e2_info: undefined,
	finished_e3: false,
	finished_e3_info: undefined,
	finished_e4: false,
	finished_e4_info: undefined,
}
test_future_race = {
	name: "test_future_race",
	expected_a: 147,
	received_a: undefined,
	expected_b: 871,
	received_b: undefined,
	expected_c: 742,
	received_c: undefined,
	finished_d: false,
	finished_d_info: undefined,
	finished_e: false,
	finished_e_info: undefined,
	finished_f: undefined,
	finished_f_info: undefined,
	finished_g: undefined,
	finished_g_info: undefined,
}
test_future_all_settled = {
	name: "test_future_all_settled",
	finished_a: false,
	finished_b: false,
	finished_c: false,
	finished_d: false,
}
test_order = {
	name: "test_order",
	expected_order: [
	    101, 103, 114,
	    202, 204, 213,
	    105, 206
	],
	received_order: [],
	is_finished: false,
}

/// TESTS

function set_frameout(_frames, _callback, _data=undefined) {
	var _context = {
		callback: _callback,
		data: _data,
	};
	var _timesource = time_source_create(time_source_game, _frames, time_source_units_frames, method(_context, function() {
		time_source_destroy(self.timesource);
			
		var _callback = self.callback;
		var _data = self.data;
		
		self.callback = undefined;
		self.data = undefined;
		
		try {
			_callback(_data);
		} catch (_error) {
			show_message(_error);
		}
	}));
		
	_context.timesource = _timesource;
 	time_source_start(_timesource);
}

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
	
	obj_future_test.set_frameout(100, function(_future) {
		
		_future.on_then(function(_value) {
			obj_future_test.test_later_resolve.is_finished = true;
			obj_future_test.test_later_resolve.received = _value;
		});
		
	}, _future);
	
}

function run_test_later_reject() {
	
	var _future = future_reject(25);
	
	obj_future_test.set_frameout(100, function(_future) {
		
		_future.on_catch(function(_value) {
			obj_future_test.test_later_reject.is_finished = true;
			obj_future_test.test_later_reject.received = _value;
		})
		
	}, _future);
	
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
		
	obj_future_test.set_frameout(100, function(_future) {
		
		_future.on_finally(functor_void);
		
	}, _future);
	
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
	
	obj_future_test.set_frameout(100, function(_future) {
		
		_future.on_then(function(_value) {
			obj_future_test.test_later_dobule_resolve.received += _value;
		});
		
	}, _future);
	
	obj_future_test.set_frameout(180, function(_future) {
		
		_future.on_then(function(_value) {
			obj_future_test.test_later_dobule_resolve.is_finished = true;
			obj_future_test.test_later_dobule_resolve.received += _value;
		});
		
	}, _future);
	
}

function run_test_later_dobule_reject() {
	
	var _future = future_reject(120);
	
	obj_future_test.set_frameout(100, function(_future) {
		
		_future.on_catch(function(_value) {
			obj_future_test.test_later_dobule_reject.received += _value;
		});
		
	}, _future);
	
	obj_future_test.set_frameout(180, function(_future) {
		
		_future.on_catch(function(_value) {
			obj_future_test.test_later_dobule_reject.is_finished = true;
			obj_future_test.test_later_dobule_reject.received += _value;
		});
		
	}, _future);
	
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
				value: _value,
				resolve: _resolve
			};
			obj_future_test.set_frameout(100, function(_data) {
				_data.resolve(_data.value);
			}, _context);
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

function run_test_resolvers() {
	
	var _context;
	var _future;
	
	_context = {};
	_future = future(method(_context, function(_resolve, _reject) {
		self.resolve = _resolve;
		self.reject = _reject;
	}));
	
	obj_future_test.test_resolvers.callable_resolve = is_callable(_context.resolve);
	obj_future_test.test_resolvers.callable_reject = is_callable(_context.reject);
	
	_future.on_then(function(_value) {
		obj_future_test.test_resolvers.resolve_received = _value;
	});
	
	obj_future_test.set_frameout(100, function(_resolve) {
		_resolve(1452);
	}, _context.resolve);
	
	_context = {};
	_future = future(method(_context, function(_resolve, _reject) {
		self.resolve = _resolve;
		self.reject = _reject;
	}));
	
	obj_future_test.test_resolvers.callable_resolve = is_callable(_context.resolve);
	obj_future_test.test_resolvers.callable_reject = is_callable(_context.reject);
	
	_future.on_catch(function(_value) {
		obj_future_test.test_resolvers.reject_received = _value;
	});
	obj_future_test.set_frameout(100, function(_reject) {
		_reject(247);
	}, _context.reject);
}

function run_test_resolvers_2() {
	var _context;
	var _future;
	
	_context = future_with_resolvers();
	_future = _context.future;
	
	obj_future_test.test_resolvers_2.callable_resolve = is_callable(_context.resolve);
	obj_future_test.test_resolvers_2.callable_reject = is_callable(_context.reject);
	
	_future.on_then(function(_value) {
		obj_future_test.test_resolvers_2.resolve_received = _value;
	});
	obj_future_test.set_frameout(100, function(_resolve) {
		_resolve(14528);
	}, _context.resolve);
	
	_context = future_with_resolvers();
	_future = _context.future;
	
	obj_future_test.test_resolvers_2.callable_resolve = is_callable(_context.resolve);
	obj_future_test.test_resolvers_2.callable_reject = is_callable(_context.reject);
	
	_future.on_catch(function(_value) {
		obj_future_test.test_resolvers_2.reject_received = _value;
	});
	obj_future_test.set_frameout(100, function(_reject) {
		_reject(2478);
	}, _context.reject);
	
}

function run_test_future_all() {
	
	future_all([])
		.on_then(function(_values) {
			if (is_array(_values) and array_length(_values) == 0) {
				obj_future_test.test_future_all.finished_a = true;
			}
		})
	
	future_all([
		future_resolve("1"),
		future_resolve("2"),
		future_resolve("3"),
	]).on_then(function(_values) {
		if (
			is_array(_values) and 
			array_length(_values) == 3 and
			array_get(_values, 0) == "1" and
			array_get(_values, 1) == "2" and
			array_get(_values, 2) == "3"
		) {
			obj_future_test.test_future_all.finished_b = true;
		}
	})
	
	future_all(([
		future_resolve("1"),
		future_reject("error 1"),
		future_resolve("3"),
		future_resolve("4"),
		future_reject("error 2")
	])).on_catch(function(_error) {
		if (_error == "error 1" || _error == "error 2") {
			obj_future_test.test_future_all.finished_c = true;
			obj_future_test.test_future_all.c_info = _error;
		}
	})
	
	future_all(([
		future_resolve("1"),
		future_reject("error 2"),
		future_resolve("3"),
		future_resolve("4"),
		future_reject("error 1")
	])).on_catch(function(_error) {
		if (_error == "error 1" || _error == "error 2") {
			obj_future_test.test_future_all.finished_c2 = true;
			obj_future_test.test_future_all.c2_info = _error;
		}
	})
	
}

function run_test_future_any() {
	
	future_any([])
		.on_catch(function(_values) {
			if (is_array(_values) and array_length(_values) == 0) {
				obj_future_test.test_future_any.finished_a = true;
			}
		})
	
	future_any(([
		future_resolve("1"),
		future_resolve("2"),
		future_resolve("3"),
	])).on_then(function(_value) {
		if (_value == "1" || _value == "2" || _value == "3") {
			obj_future_test.test_future_any.finished_b = true;
		}
	})
	
	future_any(([
		future_reject("error 1"),
		future_resolve("1"),
		future_reject("error 2"),
		future_resolve("3"),
		future_resolve("4")
	])).on_then(function(_value) {
		if (_value == "1" || _value == "3" || _value == "4") {
			obj_future_test.test_future_any.finished_c = true;
		}
	})
	
	future_any([
		future_reject("1"),
		future_reject("2"),
		future_reject("3"),
	]).on_catch(function(_values) {
		if (
			is_array(_values) and 
			array_length(_values) == 3 and
			array_get(_values, 0) == "1" and
			array_get(_values, 1) == "2" and
			array_get(_values, 2) == "3"
		) {
			obj_future_test.test_future_any.finished_d = true;
		}
	})
	
	var _e1 = future_with_resolvers();
	var _e2 = future_with_resolvers();
	
	future_any([
		_e1.future,
		_e2.future,
	]).on_then(function(_value) {
		if (_value == "right") {
			obj_future_test.test_future_any.finished_e1 = true;
			obj_future_test.test_future_any.finished_e1_info = _value;
		}
	});
	
	future_any([
		_e2.future,
		_e1.future,
	]).on_then(function(_value) {
		if (_value == "right") {
			obj_future_test.test_future_any.finished_e2 = true;
			obj_future_test.test_future_any.finished_e2_info = _value;
		}
	});
	
	_e2.resolve("right");
	_e1.resolve("left");
	
	obj_future_test.set_frameout(100, function(_data) {
		var _e1 = _data.e1;
		var _e2 = _data.e2;
		
		future_any([
			_e1,
			_e2,
		]).on_then(function(_value) {
			if (_value == "left") {
				obj_future_test.test_future_any.finished_e3 = true;
				obj_future_test.test_future_any.finished_e3_info = _value;
			}
		});
	
		future_any([
			_e2,
			_e1,
		]).on_then(function(_value) {
			if (_value == "right") {
				obj_future_test.test_future_any.finished_e4 = true;
				obj_future_test.test_future_any.finished_e4_info = _value;
			}
		});
	}, {
		e1: _e1.future,
		e2: _e2.future,
	});
	
}

function run_test_future_race() {
	
	var _a1 = future_with_resolvers();
	var _a2 = future_with_resolvers();
	
	future_race([
		_a1.future,
		_a2.future,
	]).on_then(function(_value) {
		obj_future_test.test_future_race.received_a = _value;
	});
	
	_a1.resolve(147);
	
	var _b1 = future_with_resolvers();
	var _b2 = future_with_resolvers();
	
	future_race([
		_b1.future,
		_b2.future,
	]).on_catch(function(_value) {
		obj_future_test.test_future_race.received_b = _value;
	});
	
	_b2.reject(871);
	
	var _c1 = future_with_resolvers();
	var _c2 = future_with_resolvers();
	
	future_race([
		_c1.future,
		_c2.future,
	]).on_then(function(_value) {
		obj_future_test.test_future_race.received_c = _value;
	});
	
	_c1.resolve(742);
	
	var _d1 = future_with_resolvers();
	var _d2 = future_with_resolvers();
	
	future_race([
		_d1.future,
		_d2.future,
	]).on_then(function(_value) {
		if (_value == "right") {
			obj_future_test.test_future_race.finished_d = true;
			obj_future_test.test_future_race.finished_d_info = _value;
		}
	});
	
	future_race([
		_d2.future,
		_d1.future,
	]).on_then(function(_value) {
		if (_value == "right") {
			obj_future_test.test_future_race.finished_e = true;
			obj_future_test.test_future_race.finished_e_info = _value;
		}
	});
	
	_d2.resolve("right");
	_d1.resolve("left");
	
	obj_future_test.set_frameout(100, function(_data) {
		var _d1 = _data.d1;
		var _d2 = _data.d2;
		
		future_race([
			_d1,
			_d2,
		]).on_then(function(_value) {
			if (_value == "left") {
				obj_future_test.test_future_race.finished_f = true;
				obj_future_test.test_future_race.finished_f_info = _value;
			}
		});
	
		future_race([
			_d2,
			_d1,
		]).on_then(function(_value) {
			if (_value == "right") {
				obj_future_test.test_future_race.finished_g = true;
				obj_future_test.test_future_race.finished_g_info = _value;
			}
		});
	}, {
		d1: _d1.future,
		d2: _d2.future,
	});
	
}

function run_test_future_all_settled() {
	
	future_all_settled([])
		.on_then(function(_values) {
			if (is_array(_values) and array_length(_values) == 0) {
				obj_future_test.test_future_all_settled.finished_a = true;
			}
		})
	
	future_all_settled([
		future_resolve("1"),
		future_resolve("2"),
		future_resolve("3"),
	]).on_then(function(_values) {
		if (
			is_array(_values) and 
			array_length(_values) == 3 and
			array_get(_values, 0).is_resolved == true and
			array_get(_values, 0).result == "1" and
			array_get(_values, 1).is_resolved == true and
			array_get(_values, 1).result == "2" and
			array_get(_values, 2).is_resolved == true and
			array_get(_values, 2).result == "3"
		) {
			obj_future_test.test_future_all_settled.finished_b = true;
		}
	})
	
	future_all_settled(([
		future_resolve("1"),
		future_reject("error 1"),
		future_resolve("3"),
		future_resolve("4"),
		future_reject("error 2")
	])).on_then(function(_values) {
		if (
			is_array(_values) and 
			array_length(_values) == 5 and
			array_get(_values, 0).is_resolved == true and
			array_get(_values, 0).result == "1" and
			array_get(_values, 1).is_resolved == false and
			array_get(_values, 1).result == "error 1" and
			array_get(_values, 2).is_resolved == true and
			array_get(_values, 2).result == "3" and
			array_get(_values, 3).is_resolved == true and
			array_get(_values, 3).result == "4" and
			array_get(_values, 4).is_resolved == false and
			array_get(_values, 4).result == "error 2"
		) {
			obj_future_test.test_future_all_settled.finished_c = true;
		}
	})
	
	future_all_settled(([
		future_resolve("1"),
		future_reject("error 2"),
		future_resolve("4"),
		future_reject("error 1")
	])).on_then(function(_values) {
		if (
			is_array(_values) and 
			array_length(_values) == 4 and
			array_get(_values, 0).is_resolved == true and
			array_get(_values, 0).result == "1" and
			array_get(_values, 1).is_resolved == false and
			array_get(_values, 1).result == "error 2" and
			array_get(_values, 2).is_resolved == true and
			array_get(_values, 2).result == "4" and
			array_get(_values, 3).is_resolved == false and
			array_get(_values, 3).result == "error 1"
		) {
			obj_future_test.test_future_all_settled.finished_d = true;
		}
	})
	
	
}

function run_test_order() {
	var _values = [];

	var _f1 = future(function(_resolve, _reject) {
	  _resolve(100);
	});
	var _f2 = future(function(_resolve, _reject) {
	  set_frameout(150, _resolve, 200);
	});

	_f1.on_then(function (_result) {
		array_push(obj_future_test.test_order.received_order, _result + 1);
	});
	_f2.on_then(function (_result) {
	  array_push(obj_future_test.test_order.received_order, _result + 2);
	});

	set_frameout(100, function(_data) {
	  _data.f1.on_then(function (_result) {
	    array_push(obj_future_test.test_order.received_order, _result + 3);
	  });
	  _data.f2.on_then(function (_result) {
	    array_push(obj_future_test.test_order.received_order, _result + 4);
	  });
	  _data.f2.on_then(function (_result) {
	    array_push(obj_future_test.test_order.received_order, _result + 13);
	  });
	  _data.f1.on_then(function (_result) {
	    array_push(obj_future_test.test_order.received_order, _result + 14);
	  });
	}, {
		f1: _f1,
		f2: _f2,
	});

	set_frameout(200, function(_data) {
	  _data.f1.on_then(function (_result) {
	    array_push(obj_future_test.test_order.received_order, _result + 5);
	  });
	  _data.f2.on_then(function (_result) {
	    array_push(obj_future_test.test_order.received_order, _result + 6);
	  });
	}, {
		f1: _f1,
		f2: _f2,
	});

	set_frameout(300, function () {
		if (array_equals(obj_future_test.test_order.received_order, obj_future_test.test_order.expected_order)) {
			obj_future_test.test_order.is_finished = true;
		}
	});
	
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
run_test_resolvers();
run_test_resolvers_2();
run_test_future_all();
run_test_future_any();
run_test_future_race();
run_test_future_all_settled();
run_test_order();

var _secs = 10;
alarm_set(0, game_get_speed(gamespeed_fps) * _secs);
alarm_set(1, game_get_speed(gamespeed_fps) * _secs + 5);
