
#macro FUTURE_ENABLE_WARN true

enum __FUTURE_STATUS {
	PENDING = 0,
	RESOLVING = 1,
	REJECTING = 2,
	INACTION = 3,
	RESOLVED = 10,
	REJECTED = 11,
}

function __FutureMemory() {
	
	static _memory = (function() {
		
		var _ds_map_async_http = ds_map_create();
		var _ds_map_headers = ds_map_create();
		var _memory = {
			queue_finishing: [],
			queue_finishing_swap: [],
			queue_notifications: [],
			queue_notifications_swap: [],
			uncaught_handler: undefined,
			ds_map_async_http: _ds_map_async_http,
			ds_map_headers: _ds_map_headers,
		};
		
		return _memory;
		
	})();
	
	return _memory;
	
}  

function __Future(_handler_init) constructor {
		
	#region __constructor
	{
		if (ASSERTS_ENABLE) assert(_handler_init, [
			assert_is_callable("[__Future.constructor] handler_init should be callable")
		]);
		
		self.__status = __FUTURE_STATUS.PENDING;
		self.__handler_init = _handler_init
		self.__response_result = undefined;
		self.__finished_without_subscriptions = false;
		self.__postponed_events = [];
		
		__start();
	}
	#endregion
	
	function __add_to_queue_finishing() {
		static _future_memory = __FutureMemory();
		
		var _queue_finishing = _future_memory.queue_finishing;
		array_push(_queue_finishing, self);
		
	}
	
	function __resolve(_resolved_data) {
		var _is_handling = self.__status == __FUTURE_STATUS.PENDING;
		
		if (false == _is_handling) {
			return;
		}
		
		if (is_future(_resolved_data)) {
			var _next_future = _resolved_data;
			
			self.__status = __FUTURE_STATUS.INACTION;
			
			_next_future.once(function(_is_resolved, _future_result) {
				if (_is_resolved) {
					self.__status = __FUTURE_STATUS.RESOLVING;
					self.__response_result = _future_result;
				} else {
					self.__status = __FUTURE_STATUS.REJECTING;
					self.__response_result = _future_result;
				}
				
				__add_to_queue_finishing();
			});
		} else {
			self.__status = __FUTURE_STATUS.RESOLVING;
			self.__response_result = _resolved_data;
			
			__add_to_queue_finishing();
		}
	}
	
	function __reject(_rejected_data) {
		var _is_handling = self.__status == __FUTURE_STATUS.PENDING;
		
		if (false == _is_handling) {
			return;
		}
		
		self.__status = __FUTURE_STATUS.REJECTING;
		self.__response_result = _rejected_data;
		
		__add_to_queue_finishing();
	}
	
	function __start() {
		if (false == is_callable(self.__handler_init)) {
			throw ({
				message: "dont't callbable handler init function",
			});
		}
		
		var _handler_init = self.__handler_init;
		
		self.__handler_init = undefined;
		
		var _resolve = method(self, __resolve);
		var _reject = method(self, __reject);
		
		try {
			_handler_init(_resolve, _reject);
		} catch (_error) {
			_reject(_error);
		}
	}
	
	function __subscribe(_callback_resolve, _callback_reject) {
		static _future_memory = __FutureMemory();
		
		if (FUTURE_ENABLE_WARN) {
			
			if (self.__finished_without_subscriptions) {
				show_debug_message("warn::[__Future.__subscribe] subscribe on uncaught handled future");
			}
			
		}
		
		var _future = self;
		var _event = {
			future: _future,
			resolve: _callback_resolve,
			reject: _callback_reject,
		};
		
		var _is_finished =
			self.__status == __FUTURE_STATUS.RESOLVED or self.__status == __FUTURE_STATUS.REJECTED;
			
		if (_is_finished) {
			var _queue_notifications = _future_memory.queue_notifications;
			array_push(_queue_notifications, _event);
		} else {
			array_push(self.__postponed_events, _event);
		}
	}
	
	function __finished() {
		static _future_memory = __FutureMemory();
		
		var _is_finishing =
			self.__status == __FUTURE_STATUS.RESOLVING or self.__status == __FUTURE_STATUS.REJECTING;
		
		if (false == _is_finishing) {
			return;
		}
		
		if (self.__status == __FUTURE_STATUS.RESOLVING) {
			self.__status = __FUTURE_STATUS.RESOLVED;
		} else {
			self.__status = __FUTURE_STATUS.REJECTED;
		}
		
		var _queue_notifications = _future_memory.queue_notifications;
		var _events = self.__postponed_events;
		var _events_size = array_length(_events);
		var i, _event;
		
		for (i = 0; i < _events_size; ++i) {
			_event = array_get(_events, i);
			array_push(_queue_notifications, _event);
		}
		
		self.__postponed_events = undefined;
		self.__finished_without_subscriptions = _events_size == 0;
		
		return self.__finished_without_subscriptions;
	}
	
	function once(_callback_subscription) {
		if (ASSERTS_ENABLE) assert(_callback_subscription, [
			assert_is_callable("[__Future.once] callback_subscription should be callable")
		]);
		
		var _context = {
			subscription: _callback_subscription,
		};
		var _resolve = method(_context, function(_resolved) {
			var _subscription = self.subscription;
			
			self.subscription = undefined;
			
			_subscription(true, _resolved);
		});
		var _reject = method(_context, function(_rejected) {
			var _subscription = self.subscription;
			
			self.subscription = undefined;
			
			_subscription(false, _rejected);
		});
		
		__subscribe(_resolve, _reject);
		
	}
	
	function pipe(_callback_subscription) {
		if (ASSERTS_ENABLE) assert(_callback_subscription, [
			assert_is_callable("[__Future.pipe] callback_subscription should be callable")
		]);
		
		var _fwr = future_with_resolvers();
		var _next_future = _fwr.future;
		
		_fwr.future = undefined;
		_fwr.callback_subscription = _callback_subscription;
		
		once(method(_fwr, function(_is_resolved, _future_result) {
			
			var _resolve = self.resolve;
			var _reject = self.reject;
			var _callback_subscription = self.callback_subscription;
			var _result;
			
			self.resolve = undefined;
			self.reject = undefined;
			self.callback_subscription = undefined;
			
			try {
				_result = _callback_subscription(_is_resolved, _future_result);
				_resolve(_result);
			} catch (_error) {
				_reject(_error);
			}
			
		}));
		
		return _next_future;
		
	}
	
	function on_then(_callback_then) {
		if (ASSERTS_ENABLE) assert(_callback_then, [
			assert_is_callable("[__Future.on_then] callback_then should be callable")
		]);
		
		var _context = {
			callback_then: _callback_then,
		};
		var _next_future = pipe(method(_context, function(_is_resolved, _future_result) {
			var _callback_then = self.callback_then;
			
			self.callback_then = undefined;
			
			if (_is_resolved) {
				return _callback_then(_future_result);
			} else {
				throw _future_result;
			}
		}));
		return _next_future;
	}
	
	function on_catch(_callback_catch) {
		if (ASSERTS_ENABLE) assert(_callback_catch, [
			assert_is_callable("[__Future.on_catch] callback_catch should be callable")
		]);
		
		var _context = {
			callback_catch: _callback_catch,
		};
		var _next_future = pipe(method(_context, function(_is_resolved, _future_result) {
			var _callback_catch = self.callback_catch;
			
			self.callback_catch = undefined;
			
			if (_is_resolved) {
				return _future_result;
			} else {
				return _callback_catch(_future_result);
			}
		}));
		return _next_future;
	}
	
	function on_finally(_callback_finally) {
		if (ASSERTS_ENABLE) assert(_callback_finally, [
			assert_is_callable("[__Future.on_finally] callback_finally should be callable")
		]);
		
		var _context = {
			callback_finally: _callback_finally,
		};
		
		var _next_future = pipe(method(_context, function(_is_resolved, _future_result) {
			var _callback_finally = self.callback_finally;
			
			self.callback_finally = undefined;
			
			_callback_finally();
			
			if (_is_resolved) {
				return _future_result;
			} else {
				throw _future_result;
			}
		}));
		
		return _next_future;
	}
	
	function __is_resolved() {
		return self.__status == __FUTURE_STATUS.RESOLVED;	
	}
	
	function __get_result() {
		return self.__response_result;
	}
	
}

function is_future(_value) {
	if (is_struct(_value) and is_instanceof(_value, __Future)) {
		return true;
	}
	return false;
}

function future(_handler_init) {
	if (ASSERTS_ENABLE) assert(_handler_init, [
		assert_is_callable("[future] handler_init should be callable")
	]);
	
	var _future = new __Future(_handler_init);
	return _future;
}

function future_resolve(_value=undefined) {
	var _context = {
		value: _value,	
	};
	var _future = new __Future(method(_context, function(_resolve, _reject) {
		_resolve(self.value);
	}));
	return _future;
}

function future_reject(_value) {
	var _context = {
		value: _value,	
	};
	var _future = new __Future(method(_context, function(_resolve, _reject) {
		_reject(self.value);
	}));
	return _future;
}

function future_all(_futures) {
	if (ASSERTS_ENABLE) assert(_futures, [
		assert_is_array(),
		assert_all_array_item(
			assert_instanceof(__Future)
		),
	], "[future_all] futures should be array with futures");
	
	var _futures_size = array_length(_futures);
	if (_futures_size == 0) {
		return future_resolve([]);
	}
	
	var _clone_array = extend_array_clone_shallow(_futures);
	var _context = {
		size: _futures_size,
		futures: _clone_array,
		resolved_count: 0,
	};
	var _future = new __Future(method(_context, function(_resolve, _reject) {
		self.resolve = _resolve;
		self.reject = _reject;
		
		var _futures = self.futures;
		var _futures_size = self.size;
		var _future, i;
		
		for (i = 0; i < _futures_size; ++i) {
			_future = array_get(_futures, i);
			_future.once(function(_is_resolved, _future_result) {
				if (false == is_array(self.futures)) {
					return;
				}
				
				if (_is_resolved) {
					self.resolved_count += 1;
					
					if (self.resolved_count == self.size) {
						var _resolve = self.resolve
						var _futures = self.futures;
						var _futures_size = self.size;
						var _future, _value, i;
						var _values = array_create(_futures_size);
						
						for (i = 0; i < _futures_size; ++i) {
							_future = array_get(_futures, i);
							_value = _future.__get_result();
							array_set(_values, i, _value);
						}
						
						self.futures = undefined;
						self.resolve = undefined;
						self.reject = undefined;
						
						_resolve(_values);
					}
				} else {
					var _reject = self.reject;
					
					self.futures = undefined;
					self.resolve = undefined;
					self.reject = undefined;
					
					_reject(_future_result);
				}
			});
		}
	}));
	return _future;
}

function future_any(_futures) {
	if (ASSERTS_ENABLE) assert(_futures, [
		assert_is_array(),
		assert_all_array_item(
			assert_instanceof(__Future)
		),
	], "[future_any] futures should be array with futures");
	
	var _futures_size = array_length(_futures);
	if (_futures_size == 0) {
		return future_reject([]);
	}
	
	var _clone_array = extend_array_clone_shallow(_futures);
	var _context = {
		size: _futures_size,
		futures: _clone_array,
		rejected_count: 0,
	};
	var _future = new __Future(method(_context, function(_resolve, _reject) {
		self.resolve = _resolve;
		self.reject = _reject;
		
		var _futures = self.futures;
		var _futures_size = self.size;
		var _future, i;
		
		for (i = 0; i < _futures_size; ++i) {
			_future = array_get(_futures, i);
			_future.once(function(_is_resolved, _future_result) {
				if (false == is_array(self.futures)) {
					return;
				}
				
				if (_is_resolved) {
					var _resolve = self.resolve;
					
					self.futures = undefined;
					self.resolve = undefined;
					self.reject = undefined;
					
					_resolve(_future_result);
					
				} else {
					self.rejected_count += 1;
					
					if (self.rejected_count == self.size) {
						var _reject = self.reject
						var _futures = self.futures;
						var _futures_size = self.size;
						var _future, _value, i;
						var _values = array_create(_futures_size);
						
						for (i = 0; i < _futures_size; ++i) {
							_future = array_get(_futures, i);
							_value = _future.__get_result();
							array_set(_values, i, _value);
						}
						
						self.futures = undefined;
						self.resolve = undefined;
						self.reject = undefined;
						
						_reject(_values);
					}
				}
			});
		}
	}));
	return _future;
}

function future_race(_futures) {
	if (ASSERTS_ENABLE) assert(_futures, [
		assert_is_array(),
		assert_all_array_item(
			assert_instanceof(__Future)
		),
	], "[future_race] futures should be array with futures");
	
	var _clone_array = extend_array_clone_shallow(_futures);
	var _context = {
		futures: _clone_array,
	};
	var _future = new __Future(method(_context, function(_resolve, _reject) {
		self.resolve = _resolve;
		self.reject = _reject;
		
		var _futures = self.futures;
		var _futures_size = array_length(_futures);
		var _future, i;
		
		for (i = 0; i < _futures_size; ++i) {
			_future = array_get(_futures, i);
			_future.once(function(_is_resolved, _future_result) {
				if (false == is_array(self.futures)) {
					return;
				}
				
				var _resolve = self.resolve;
				var _reject = self.reject;
				
				self.futures = undefined;
				self.resolve = undefined;
				self.reject = undefined;
				
				if (_is_resolved) {
					_resolve(_future_result);
				} else {
					_reject(_future_result);
				}
			});
		}
	}));
	return _future;
}

function future_all_settled(_futures) {
	if (ASSERTS_ENABLE) assert(_futures, [
		assert_is_array(),
		assert_all_array_item(
			assert_instanceof(__Future)
		),
	], "[future_all_settled] futures should be array with futures");
	
	var _futures_size = array_length(_futures);
	if (_futures_size == 0) {
		return future_resolve([]);
	}
	
	var _clone_array = extend_array_clone_shallow(_futures);
	var _context = {
		size: _futures_size,
		futures: _clone_array,
		count: 0,
	};
	var _future = new __Future(method(_context, function(_resolve) {
		self.resolve = _resolve;
		
		var _futures = self.futures;
		var _futures_size = self.size;
		var _future, i;
		
		for (i = 0; i < _futures_size; ++i) {
			_future = array_get(_futures, i);
			_future.once(function() {
				if (false == is_array(self.futures)) {
					return;
				}
				
				self.count += 1;
				
				if (self.count == self.size) {
					var _resolve = self.resolve;
					var _futures = self.futures;
					var _futures_size = self.size;
					var _future, _result, _is_resolved, i;
					var _values = array_create(_futures_size);
					var _value;
					
					for (i = 0; i < _futures_size; ++i) {
						_future = array_get(_futures, i);
						_is_resolved = _future.__is_resolved();
						_result = _future.__get_result();
						_value = {
							is_resolved: _is_resolved,
							result: _result,
						};
						array_set(_values, i, _value);
					}
					
					self.futures = undefined;
					self.resolve = undefined;
					
					_resolve(_values);
				}
			});
		}
	}));
	return _future;
}

function future_with_resolvers() {
	var _uncontext = {};
	var _future = new __Future(method(_uncontext, function(_resolve, _reject) {
		self.resolve = _resolve;
		self.reject = _reject;
	}));
	var _resolve = _uncontext.resolve;
	var _reject = _uncontext.reject;
	
	_uncontext.resolve = undefined;
	_uncontext.reject = undefined;
	
	var _result = {
		future: _future,
		resolve: _resolve,
		reject: _reject,
	};
	
	return _result;
}

function future_get_uncaught_handler() {
	
	return __FutureMemory().uncaught_handler;
}

function future_set_uncaught_handler(_handler) {
	if (ASSERTS_ENABLE) assert(_handler, [
		assert_any([
			assert_is_callable()
		], "[future_set_uncaught_handler] handler should be callable"),
	]);
	
	__FutureMemory().uncaught_handler = _handler;
}
