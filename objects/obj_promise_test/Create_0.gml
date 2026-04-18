
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
test_promise_all = {
	name: "test_promise_all",
	finished_a: false,
	finished_b: false,
	finished_c: false,
	finished_c2: false,
	c_info: undefined,
	c2_info: undefined,
}
test_promise_any = {
	name: "test_promise_any",
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
test_promise_race = {
	name: "test_promise_race",
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
test_promise_all_settled = {
	name: "test_promise_all_settled",
	finished_a: false,
	finished_b: false,
	finished_c: false,
	finished_d: false,
}
test_order = {
	name: "test_order",
	expected_order: [
	  101, 103, 114, 202, 204, 213,
	  105, 206,  40,  50,  70,  60,
	   90,  80,  54,  44,  64,  74,
	   94,  84
	],
	received_order: [],
	is_finished: false,
}
test_http = {
	name: "test_http",
	is_finished_create: false,
	is_finished_delete: false,
	is_finished_get: false,
	is_finished_get_not_found: false,
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

function call_api_jsonplaceholder_get_post(_id) {
	var _base_url = "https://jsonplaceholder.typicode.com/posts/";
	var _url = _base_url + string(_id);
	
	return async_http_request(_url).on_then(function(_async_object) {
		return json_parse(_async_object.response);
	});
}

function call_api_jsonplaceholder_delete_post(_id) {
	var _base_url = "https://jsonplaceholder.typicode.com/posts/";
	var _url = _base_url + string(_id);
	
	return async_http_request(_url, "delete").on_then(function(_async_object) {
		return json_parse(_async_object.response);
	});
}

function call_api_jsonplaceholder_create_post(_title, _body, _userId) {
	var _base_url = "https://jsonplaceholder.typicode.com/posts/";
	
	return async_http_request(_base_url, "post", {
		title: _title,
		body: _body,
		userId: _userId,
	}, {
		"Content-type": "application/json; charset=UTF-8",
	}).on_then(function(_async_object) {
		return json_parse(_async_object.response);
	});
}

function run_test_resolve() {
	
	promise_resolve(23).on_then(function(_value) {
		obj_promise_test.test_resolve.is_finished = true;
		obj_promise_test.test_resolve.received = _value;
	})
	
}

function run_test_reject() {
	
	promise_reject(64).on_catch(function(_value) {
		obj_promise_test.test_reject.is_finished = true;
		obj_promise_test.test_reject.received = _value;
	});
	
}

function run_test_later_resolve() {
	
	var _promise = promise_resolve(80);
	
	obj_promise_test.set_frameout(100, function(_promise) {
		
		_promise.on_then(function(_value) {
			obj_promise_test.test_later_resolve.is_finished = true;
			obj_promise_test.test_later_resolve.received = _value;
		});
		
	}, _promise);
	
}

function run_test_later_reject() {
	
	var _promise = promise_reject(25);
	
	obj_promise_test.set_frameout(100, function(_promise) {
		
		_promise.on_catch(function(_value) {
			obj_promise_test.test_later_reject.is_finished = true;
			obj_promise_test.test_later_reject.received = _value;
		})
		
	}, _promise);
	
}

function run_test_uncaught_handler() {
	
	var _error = function() {
		obj_promise_test.test_uncaught_handler.is_finished = true;
	}
	var _promise = promise_reject(_error);
	
}

function run_test_uncaught_handler_2() {
	
	var _error = function() {
		obj_promise_test.test_uncaught_handler_2.is_finished = true;
	}
	var _promise = promise_reject(_error)
		.on_then(functor_void)
		.on_finally(functor_void)
	
}

function run_test_uncaught_handler_3() {
	
	var _error = function() {
		obj_promise_test.test_uncaught_handler_3.is_finished = true;
	}
	var _promise = promise_reject(_error)
		.on_then(functor_void)
		.on_finally(functor_void)
		.on_catch(functor_throw);
	
}

function run_test_uncaught_handler_4() {
	
	var _error = function() {
		obj_promise_test.test_uncaught_handler_4.received += 1;
	}
	var _promise = promise_reject(_error);
	
	_promise
		.on_then(functor_void)
		.on_catch(functor_void);
	
	_promise
		.on_then(functor_void);
	
	_promise
		.on_finally(functor_void);
		
	obj_promise_test.set_frameout(100, function(_promise) {
		
		_promise.on_finally(functor_void);
		
	}, _promise);
	
}

function run_test_reject_after_throw() {
	
	var _promise = promise(function() {
		throw 68;
	});
	
	_promise.on_catch(function(_value) {
		obj_promise_test.test_reject_after_throw.is_finished = true;
		obj_promise_test.test_reject_after_throw.received = _value;
	});
	
}

function run_test_finally_after_resolve() {
	
	promise_resolve(100)
		.on_then(function(_value) {
			obj_promise_test.test_finally_after_resolve.received_a = _value * 2;
		})
		.on_finally(function() {
			obj_promise_test.test_finally_after_resolve.received_a = 36;
			return 2234;
		})
		.on_then(function(_value) {
			obj_promise_test.test_finally_after_resolve.received_a = _value;
		})
		.on_finally(function() {
			obj_promise_test.test_finally_after_resolve.received_a = 771;
			return 2234;
		});
		
	promise_resolve(518)
		.on_finally(function() {
			obj_promise_test.test_finally_after_resolve.received_b = 100;
			return 2234;
		})
		.on_finally(function() {
			obj_promise_test.test_finally_after_resolve.received_b = 150;
			return 2234;
		})
		.on_then(function(_value) {
			obj_promise_test.test_finally_after_resolve.received_b = _value * 2;
			return _value;
		})
		.on_finally(function() {
			obj_promise_test.test_finally_after_resolve.received_b = 100;
			return 2234;
		})
		.on_then(function(_value) {
			obj_promise_test.test_finally_after_resolve.received_b = _value;
		})
}

function run_test_finally_after_reject() {
 	
	promise_reject(100)
		.on_then(function(_value) {
			obj_promise_test.test_finally_after_reject.received_a = _value * 2;
		})
		.on_finally(function() {
			obj_promise_test.test_finally_after_reject.received_a = 36;
			return 2234;
		})
		.on_then(function(_value) {
			obj_promise_test.test_finally_after_reject.received_a = _value;
		})
		.on_finally(function() {
			obj_promise_test.test_finally_after_reject.received_a = 227;
			return 2234; 
		});
		
	promise_reject(632)
		.on_finally(function() {
			obj_promise_test.test_finally_after_reject.received_b = 100;
			return 2234;
		})
		.on_finally(function() {
			obj_promise_test.test_finally_after_reject.received_b = 150;
			return 2234;
		})
		.on_then(function(_value) {
			obj_promise_test.test_finally_after_reject.received_b = _value * 2;
			return _value;
		})
		.on_catch(function(_value) {
			obj_promise_test.test_finally_after_reject.received_b = _value * 10;
			throw _value;
		})
		.on_finally(function() {
			obj_promise_test.test_finally_after_reject.received_b = 100;
			return 2234;
		})
		.on_then(function(_value) {
			obj_promise_test.test_finally_after_reject.received_b = _value * 3;
		})
		.on_catch(function(_value) {
			obj_promise_test.test_finally_after_reject.received_b = _value;
		});
}

function run_test_later_dobule_resolve() {
	
	var _promise = promise_resolve(60);
	
	obj_promise_test.set_frameout(100, function(_promise) {
		
		_promise.on_then(function(_value) {
			obj_promise_test.test_later_dobule_resolve.received += _value;
		});
		
	}, _promise);
	
	obj_promise_test.set_frameout(180, function(_promise) {
		
		_promise.on_then(function(_value) {
			obj_promise_test.test_later_dobule_resolve.is_finished = true;
			obj_promise_test.test_later_dobule_resolve.received += _value;
		});
		
	}, _promise);
	
}

function run_test_later_dobule_reject() {
	
	var _promise = promise_reject(120);
	
	obj_promise_test.set_frameout(100, function(_promise) {
		
		_promise.on_catch(function(_value) {
			obj_promise_test.test_later_dobule_reject.received += _value;
		});
		
	}, _promise);
	
	obj_promise_test.set_frameout(180, function(_promise) {
		
		_promise.on_catch(function(_value) {
			obj_promise_test.test_later_dobule_reject.is_finished = true;
			obj_promise_test.test_later_dobule_reject.received += _value;
		});
		
	}, _promise);
	
}

function run_test_correct_chain() {
	
	var _p1 = promise_resolve("begin");
	
	var _p2 = _p1.on_then(function(_value) {
		obj_promise_test.test_correct_chain.on_1_received = _value;
		
		return (_value + " and end");
	});
	
	var _p3 = _p2.on_finally(function() {
		obj_promise_test.test_correct_chain.on_2_received = "on_2_expected";
	}); 
	
	var _p4 = _p3.on_then(function(_value) {
		obj_promise_test.test_correct_chain.on_3_received = _value;
		
		return "again";
	});
	
	var _p5 = _p4.on_then(function(_value) {
		obj_promise_test.test_correct_chain.on_4_received = _value;
		
		throw ">>is error";
	});
	
	var _p6 = _p5.on_then(function(_value) {
		obj_promise_test.test_correct_chain.on_5_received = "not working";
	});
	
	var _p7 = _p6.on_finally(function(_value) {
		obj_promise_test.test_correct_chain.on_6_received = "on_6_expected";
	});
	
	var _p8 = _p7.on_catch(function(_value) {
		obj_promise_test.test_correct_chain.on_7_received = _value;
		
		return "error handled";
	});
	
	var _p9 = _p8.on_then(function(_value) {
		obj_promise_test.test_correct_chain.on_8_received = _value;
		
		return "timeout";
	});
	
	var _p10_timeout = _p9.on_then(function(_value) {
		
		var _context = {
			value: _value,	
		};
		var _timeout_promise = promise(method(_context, function(_resolve) {
			var _value = self.value;
			var _context = {
				value: _value,
				resolve: _resolve
			};
			obj_promise_test.set_frameout(100, function(_data) {
				_data.resolve(_data.value);
			}, _context);
		}));
		
		return _timeout_promise;
		
	});
	
	var _p10 = _p10_timeout.on_then(function(_value) {
		obj_promise_test.test_correct_chain.on_9_received = _value;
		
		return promise_reject(">>is reject");
	});
	
	var _p11 = _p10.on_catch(function(_value) {
		obj_promise_test.test_correct_chain.on_10_received = _value;
		
		throw promise_resolve();
	});
	
	var _p12 = _p11.on_catch(function(_value) {
		obj_promise_test.test_correct_chain.on_11_received = is_promise(_value);
	});
	
	var _promises = {
		f1: _p1,
		f2: _p2,
		f3: _p3,
		f4: _p4,
		f5: _p5,
		f6: _p6,
		f7: _p7,
		f8: _p8,
		f9: _p9,
		f10: _p10,
		f11: _p11,
	}
	
	var _context = {
		promises: _promises,
	};
	var _timesource = time_source_create(time_source_game, 200, time_source_units_frames, method(_context, function() {
		time_source_destroy(self.timesource);
		
		self.promises.f1.on_then(function(_value) {
			obj_promise_test.test_correct_chain.on_1_received_later = _value;
		})
		self.promises.f2.on_finally(function() {
			obj_promise_test.test_correct_chain.on_2_received_later = "on_2_expected";
		})
		self.promises.f3.on_then(function(_value) {
			obj_promise_test.test_correct_chain.on_3_received_later = _value;
		})
		self.promises.f4.on_then(function(_value) {
			obj_promise_test.test_correct_chain.on_4_received_later = _value;
		})
		self.promises.f5.on_then(function(_value) {
			obj_promise_test.test_correct_chain.on_5_received_later = _value;
		})
		self.promises.f6.on_finally(function() {
			obj_promise_test.test_correct_chain.on_6_received_later = "on_6_expected";
		})
		self.promises.f7.on_catch(function(_value) {
			obj_promise_test.test_correct_chain.on_7_received_later = _value;
		})
		self.promises.f8.on_then(function(_value) {
			obj_promise_test.test_correct_chain.on_8_received_later = _value;
		})
		self.promises.f9.on_then(function(_value) {
			obj_promise_test.test_correct_chain.on_9_received_later = _value;
		})
		self.promises.f10.on_catch(function(_value) {
			obj_promise_test.test_correct_chain.on_10_received_later = _value;
		})
		self.promises.f11.on_catch(function(_value) {
			obj_promise_test.test_correct_chain.on_11_received_later = is_promise(_value);
		});
		
	}));
	
	_context.timesource = _timesource;
	time_source_start(_timesource);
	
}

function run_test_resolvers() {
	
	var _context;
	var _promise;
	
	_context = {};
	_promise = promise(method(_context, function(_resolve, _reject) {
		self.resolve = _resolve;
		self.reject = _reject;
	}));
	
	obj_promise_test.test_resolvers.callable_resolve = is_callable(_context.resolve);
	obj_promise_test.test_resolvers.callable_reject = is_callable(_context.reject);
	
	_promise.on_then(function(_value) {
		obj_promise_test.test_resolvers.resolve_received = _value;
	});
	
	obj_promise_test.set_frameout(100, function(_resolve) {
		_resolve(1452);
	}, _context.resolve);
	
	_context = {};
	_promise = promise(method(_context, function(_resolve, _reject) {
		self.resolve = _resolve;
		self.reject = _reject;
	}));
	
	obj_promise_test.test_resolvers.callable_resolve = is_callable(_context.resolve);
	obj_promise_test.test_resolvers.callable_reject = is_callable(_context.reject);
	
	_promise.on_catch(function(_value) {
		obj_promise_test.test_resolvers.reject_received = _value;
	});
	obj_promise_test.set_frameout(100, function(_reject) {
		_reject(247);
	}, _context.reject);
}

function run_test_resolvers_2() {
	var _context;
	var _promise;
	
	_context = promise_with_resolvers();
	_promise = _context.promise;
	
	obj_promise_test.test_resolvers_2.callable_resolve = is_callable(_context.resolve);
	obj_promise_test.test_resolvers_2.callable_reject = is_callable(_context.reject);
	
	_promise.on_then(function(_value) {
		obj_promise_test.test_resolvers_2.resolve_received = _value;
	});
	obj_promise_test.set_frameout(100, function(_resolve) {
		_resolve(14528);
	}, _context.resolve);
	
	_context = promise_with_resolvers();
	_promise = _context.promise;
	
	obj_promise_test.test_resolvers_2.callable_resolve = is_callable(_context.resolve);
	obj_promise_test.test_resolvers_2.callable_reject = is_callable(_context.reject);
	
	_promise.on_catch(function(_value) {
		obj_promise_test.test_resolvers_2.reject_received = _value;
	});
	obj_promise_test.set_frameout(100, function(_reject) {
		_reject(2478);
	}, _context.reject);
	
}

function run_test_promise_all() {
	
	promise_all([])
		.on_then(function(_values) {
			if (is_array(_values) and array_length(_values) == 0) {
				obj_promise_test.test_promise_all.finished_a = true;
			}
		})
	
	promise_all([
		promise_resolve("1"),
		promise_resolve("2"),
		promise_resolve("3"),
	]).on_then(function(_values) {
		if (
			is_array(_values) and 
			array_length(_values) == 3 and
			array_get(_values, 0) == "1" and
			array_get(_values, 1) == "2" and
			array_get(_values, 2) == "3"
		) {
			obj_promise_test.test_promise_all.finished_b = true;
		}
	})
	
	promise_all(([
		promise_resolve("1"),
		promise_reject("error 1"),
		promise_resolve("3"),
		promise_resolve("4"),
		promise_reject("error 2")
	])).on_catch(function(_error) {
		if (_error == "error 1" || _error == "error 2") {
			obj_promise_test.test_promise_all.finished_c = true;
			obj_promise_test.test_promise_all.c_info = _error;
		}
	})
	
	promise_all(([
		promise_resolve("1"),
		promise_reject("error 2"),
		promise_resolve("3"),
		promise_resolve("4"),
		promise_reject("error 1")
	])).on_catch(function(_error) {
		if (_error == "error 1" || _error == "error 2") {
			obj_promise_test.test_promise_all.finished_c2 = true;
			obj_promise_test.test_promise_all.c2_info = _error;
		}
	})
	
}

function run_test_promise_any() {
	
	promise_any([])
		.on_catch(function(_values) {
			if (is_array(_values) and array_length(_values) == 0) {
				obj_promise_test.test_promise_any.finished_a = true;
			}
		})
	
	promise_any(([
		promise_resolve("1"),
		promise_resolve("2"),
		promise_resolve("3"),
	])).on_then(function(_value) {
		if (_value == "1" || _value == "2" || _value == "3") {
			obj_promise_test.test_promise_any.finished_b = true;
		}
	})
	
	promise_any(([
		promise_reject("error 1"),
		promise_resolve("1"),
		promise_reject("error 2"),
		promise_resolve("3"),
		promise_resolve("4")
	])).on_then(function(_value) {
		if (_value == "1" || _value == "3" || _value == "4") {
			obj_promise_test.test_promise_any.finished_c = true;
		}
	})
	
	promise_any([
		promise_reject("1"),
		promise_reject("2"),
		promise_reject("3"),
	]).on_catch(function(_values) {
		if (
			is_array(_values) and 
			array_length(_values) == 3 and
			array_get(_values, 0) == "1" and
			array_get(_values, 1) == "2" and
			array_get(_values, 2) == "3"
		) {
			obj_promise_test.test_promise_any.finished_d = true;
		}
	})
	
	var _e1 = promise_with_resolvers();
	var _e2 = promise_with_resolvers();
	
	promise_any([
		_e1.promise,
		_e2.promise,
	]).on_then(function(_value) {
		if (_value == "right") {
			obj_promise_test.test_promise_any.finished_e1 = true;
			obj_promise_test.test_promise_any.finished_e1_info = _value;
		}
	});
	
	promise_any([
		_e2.promise,
		_e1.promise,
	]).on_then(function(_value) {
		if (_value == "right") {
			obj_promise_test.test_promise_any.finished_e2 = true;
			obj_promise_test.test_promise_any.finished_e2_info = _value;
		}
	});
	
	_e2.resolve("right");
	_e1.resolve("left");
	
	obj_promise_test.set_frameout(100, function(_data) {
		var _e1 = _data.e1;
		var _e2 = _data.e2;
		
		promise_any([
			_e1,
			_e2,
		]).on_then(function(_value) {
			if (_value == "left") {
				obj_promise_test.test_promise_any.finished_e3 = true;
				obj_promise_test.test_promise_any.finished_e3_info = _value;
			}
		});
	
		promise_any([
			_e2,
			_e1,
		]).on_then(function(_value) {
			if (_value == "right") {
				obj_promise_test.test_promise_any.finished_e4 = true;
				obj_promise_test.test_promise_any.finished_e4_info = _value;
			}
		});
	}, {
		e1: _e1.promise,
		e2: _e2.promise,
	});
	
}

function run_test_promise_race() {
	
	var _a1 = promise_with_resolvers();
	var _a2 = promise_with_resolvers();
	
	promise_race([
		_a1.promise,
		_a2.promise,
	]).on_then(function(_value) {
		obj_promise_test.test_promise_race.received_a = _value;
	});
	
	_a1.resolve(147);
	
	var _b1 = promise_with_resolvers();
	var _b2 = promise_with_resolvers();
	
	promise_race([
		_b1.promise,
		_b2.promise,
	]).on_catch(function(_value) {
		obj_promise_test.test_promise_race.received_b = _value;
	});
	
	_b2.reject(871);
	
	var _c1 = promise_with_resolvers();
	var _c2 = promise_with_resolvers();
	
	promise_race([
		_c1.promise,
		_c2.promise,
	]).on_then(function(_value) {
		obj_promise_test.test_promise_race.received_c = _value;
	});
	
	_c1.resolve(742);
	
	var _d1 = promise_with_resolvers();
	var _d2 = promise_with_resolvers();
	
	promise_race([
		_d1.promise,
		_d2.promise,
	]).on_then(function(_value) {
		if (_value == "right") {
			obj_promise_test.test_promise_race.finished_d = true;
			obj_promise_test.test_promise_race.finished_d_info = _value;
		}
	});
	
	promise_race([
		_d2.promise,
		_d1.promise,
	]).on_then(function(_value) {
		if (_value == "right") {
			obj_promise_test.test_promise_race.finished_e = true;
			obj_promise_test.test_promise_race.finished_e_info = _value;
		}
	});
	
	_d2.resolve("right");
	_d1.resolve("left");
	
	obj_promise_test.set_frameout(100, function(_data) {
		var _d1 = _data.d1;
		var _d2 = _data.d2;
		
		promise_race([
			_d1,
			_d2,
		]).on_then(function(_value) {
			if (_value == "left") {
				obj_promise_test.test_promise_race.finished_f = true;
				obj_promise_test.test_promise_race.finished_f_info = _value;
			}
		});
	
		promise_race([
			_d2,
			_d1,
		]).on_then(function(_value) {
			if (_value == "right") {
				obj_promise_test.test_promise_race.finished_g = true;
				obj_promise_test.test_promise_race.finished_g_info = _value;
			}
		});
	}, {
		d1: _d1.promise,
		d2: _d2.promise,
	});
	
}

function run_test_promise_all_settled() {
	
	promise_all_settled([])
		.on_then(function(_values) {
			if (is_array(_values) and array_length(_values) == 0) {
				obj_promise_test.test_promise_all_settled.finished_a = true;
			}
		})
	
	promise_all_settled([
		promise_resolve("1"),
		promise_resolve("2"),
		promise_resolve("3"),
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
			obj_promise_test.test_promise_all_settled.finished_b = true;
		}
	})
	
	promise_all_settled(([
		promise_resolve("1"),
		promise_reject("error 1"),
		promise_resolve("3"),
		promise_resolve("4"),
		promise_reject("error 2")
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
			obj_promise_test.test_promise_all_settled.finished_c = true;
		}
	})
	
	promise_all_settled(([
		promise_resolve("1"),
		promise_reject("error 2"),
		promise_resolve("4"),
		promise_reject("error 1")
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
			obj_promise_test.test_promise_all_settled.finished_d = true;
		}
	})
	
	
}

function run_test_order() {
	var _values = [];

	var _p1 = promise(function(_resolve, _reject) {
	  _resolve(100);
	});
	var _p2 = promise(function(_resolve, _reject) {
	  set_frameout(150, _resolve, 200);
	});

	_p1.on_then(function (_result) {
		array_push(obj_promise_test.test_order.received_order, _result + 1);
	});
	_p2.on_then(function (_result) {
	  array_push(obj_promise_test.test_order.received_order, _result + 2);
	});

	set_frameout(100, function(_data) {
	  _data.f1.on_then(function (_result) {
	    array_push(obj_promise_test.test_order.received_order, _result + 3);
	  });
	  _data.f2.on_then(function (_result) {
	    array_push(obj_promise_test.test_order.received_order, _result + 4);
	  });
	  _data.f2.on_then(function (_result) {
	    array_push(obj_promise_test.test_order.received_order, _result + 13);
	  });
	  _data.f1.on_then(function (_result) {
	    array_push(obj_promise_test.test_order.received_order, _result + 14);
	  });
	}, {
		f1: _p1,
		f2: _p2,
	});

	set_frameout(200, function(_data) {
	  _data.f1.on_then(function (_result) {
	    array_push(obj_promise_test.test_order.received_order, _result + 5);
	  });
	  _data.f2.on_then(function (_result) {
	    array_push(obj_promise_test.test_order.received_order, _result + 6);
	  });
	}, {
		f1: _p1,
		f2: _p2,
	});
	
	set_frameout(250, function(_p1) {
		var _pa = promise_with_resolvers();
		var _pb = promise_with_resolvers();
		var _pc = promise_with_resolvers();

		_pa.resolve();
		_p1.on_then(function () {
			array_push(obj_promise_test.test_order.received_order, 40);
		});
		_pa.promise.on_then(function () {
			array_push(obj_promise_test.test_order.received_order, 50);
		});

		_p1.on_then(function () {
			array_push(obj_promise_test.test_order.received_order, 70);
		});
		_pb.resolve();
		_pb.promise.on_then(function () {
			array_push(obj_promise_test.test_order.received_order, 60);
		});

		_p1.on_then(function () {
			array_push(obj_promise_test.test_order.received_order, 90);
		});
		_pc.promise.on_then(function () {
			array_push(obj_promise_test.test_order.received_order, 80);
		});
		_pc.resolve();

		var _pa2 = promise_with_resolvers();
		var _pb2 = promise_with_resolvers();
		var _pc2 = promise_with_resolvers();

		_pa2.resolve();
		_pa2.promise.on_then(function () {
			array_push(obj_promise_test.test_order.received_order, 54);
		});
		_p1.on_then(function () {
			array_push(obj_promise_test.test_order.received_order, 44);
		});

		_pb2.promise.on_then(function () {
			array_push(obj_promise_test.test_order.received_order, 64);
		});
		_pb2.resolve();
		_p1.on_then(function () {
			array_push(obj_promise_test.test_order.received_order, 74);
		});

		_pc2.promise.on_then(function () {
			array_push(obj_promise_test.test_order.received_order, 84);
		});
		_p1.on_then(function () {
			array_push(obj_promise_test.test_order.received_order, 94);
		});
		_pc2.resolve();
	}, _p1);

	set_frameout(300, function () {
		if (array_equals(obj_promise_test.test_order.received_order, obj_promise_test.test_order.expected_order)) {
			obj_promise_test.test_order.is_finished = true;
		} else {
			show_message(obj_promise_test.test_order.received_order)
		}
	});
	
}

function run_test_http() {
	
	call_api_jsonplaceholder_get_post("not-found").on_catch(function(_response) {
		
		var _is_not_found = _response.status_code == 404;
		
		obj_promise_test.test_http.is_finished_get_not_found = _is_not_found;
		
	});

	call_api_jsonplaceholder_get_post(1).on_then(function(_response) {
		
		var _some =
			_response.userId == 1 and
			_response.id == 1 and
			_response.title == "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
		
		obj_promise_test.test_http.is_finished_get = _some;
		
	});
	
	call_api_jsonplaceholder_delete_post(1).on_then(function(_response) {
		
		var _some = variable_struct_names_count(_response) == 0;
		
		obj_promise_test.test_http.is_finished_delete = _some;
		
	});
	
	call_api_jsonplaceholder_create_post("neva", { metadata: "soul" }, 11).on_then(function(_response) {
		
		var _some =
			_response.userId == 11 and
			_response.id == 101 and
			_response.title == "neva" and
			_response.body.metadata == "soul"
		
		obj_promise_test.test_http.is_finished_create = _some;
		
	});
	
}

/// RUN

promise_set_uncaught_handler(function(_maybe_callable) {
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
run_test_promise_all();
run_test_promise_any();
run_test_promise_race();
run_test_promise_all_settled();
run_test_order();
run_test_http();

var _secs = 10;
alarm_set(0, game_get_speed(gamespeed_fps) * _secs);
alarm_set(1, game_get_speed(gamespeed_fps) * _secs + 5);
