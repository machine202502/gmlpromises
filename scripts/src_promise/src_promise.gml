
#macro PROMISE_ENABLE_WARN	true

enum __PROMISE_STATUS {
	PENDING = 0,
	HANDLING = 1,
	RESOLVED = 10,
	REJECTED = 11,
}

function __PromiseMemory() {
	
	static _memory = (function() {
		
		var _ds_map_async_http = ds_map_create();
		var _ds_map_headers = ds_map_create();
		var _memory = {
			queue_end: [],
			queue_end_swap: [],
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

function __Promise(_handler_init) constructor {
		
	#region __constructor
	{
		if (ASSERTS_ENABLE) assert(_handler_init, [
			assert_is_callable("[__Promise.constructor] handler_init should be callable")
		]);
		
		self.__status = __PROMISE_STATUS.PENDING;
		self.__handler_init = _handler_init
		self.__response_result = undefined;
		self.__never_subscribed = true;
		self.__rejected_without_subscriptions = false;
		self.__postponed_events = [];
		
		__start();
	}
	#endregion
	
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
	
	function __resolve(_resolved_data) {
		var _is_pending = self.__status == __PROMISE_STATUS.PENDING;
		
		if (false == _is_pending) {
			return;
		}
		
		self.__status = __PROMISE_STATUS.HANDLING;
		
		if (is_promise(_resolved_data)) {
			var _next_promise = _resolved_data;
			
			_next_promise.__subscribe(function(_is_resolved, _promise_result) {
				__handling(_is_resolved, _promise_result);
			});
		} else {
			__handling(true, _resolved_data);
		}
	}
	
	function __reject(_rejected_data) {
		var _is_pending = self.__status == __PROMISE_STATUS.PENDING;
		
		if (false == _is_pending) {
			return;
		}
		
		self.__status = __PROMISE_STATUS.HANDLING;
		
		__handling(false, _rejected_data);
	}
	
	function __handling(_is_resolved, _promise_result) {
		static _promise_memory = __PromiseMemory();
		
		var _is_handling =
			self.__status == __PROMISE_STATUS.HANDLING;
		
		if (false == _is_handling) {
			return;
		}
		
		if (_is_resolved) {
			self.__status = __PROMISE_STATUS.RESOLVED;
		} else {
			self.__status = __PROMISE_STATUS.REJECTED;
		}
		self.__response_result = _promise_result;
		
		var _queue_end = _promise_memory.queue_end;
		var _queue_notifications = _promise_memory.queue_notifications;
		var _events = self.__postponed_events;
		var _events_size = array_length(_events);
		var _promise = self;
		var i, _event, _notification;
		
		for (i = 0; i < _events_size; ++i) {
			_event = array_get(_events, i);
			_promise = self;
			_notification = {
				promise: _promise,
				callback_subscription: _event,
			}
			array_push(_queue_notifications, _notification);
		}
		
		self.__postponed_events = undefined;
		
		array_push(_queue_end, _promise);
	}
	
	function __end() {
		var _result = self.__response_result;
		var _is_rejected = self.__status == __PROMISE_STATUS.REJECTED;
		var _never_subscribed = self.__never_subscribed;
		
		if (_is_rejected and _never_subscribed) {
			self.__rejected_without_subscriptions = true;
			throw _result;
		}
	}
	
	function __subscribe(_callback_subscription) {
		if (ASSERTS_ENABLE) assert(_callback_subscription, [
			assert_is_callable("[__Promise.__subscribe] callback_subscription should be callable")
		]);
		
		if (PROMISE_ENABLE_WARN) {
			
			if (self.__rejected_without_subscriptions) {
				show_debug_message("warn::[__Promise.__subscribe] subscribe on uncaught handled promise");
			}
			
		}
		
		static _promise_memory = __PromiseMemory();
		
		self.__never_subscribed = false;
		
		var _is_finished =
			self.__status == __PROMISE_STATUS.RESOLVED or self.__status == __PROMISE_STATUS.REJECTED;
			
		if (_is_finished) {
			var _queue_notifications = _promise_memory.queue_notifications;
			var _promise = self;
			var _notification = {
				promise: _promise,
				callback_subscription: _callback_subscription,
			}
			array_push(_queue_notifications, _notification);
		} else {
			array_push(self.__postponed_events, _callback_subscription);
		}
		
	}
	
	function on(_callback_subscription) {
		if (ASSERTS_ENABLE) assert(_callback_subscription, [
			assert_is_callable("[__Promise.on] callback_subscription should be callable")
		]);
		
		var _pwr = promise_with_resolvers();
		var _next_promise = _pwr.promise;
		
		_pwr.promise = undefined;
		_pwr.callback_subscription = _callback_subscription;
		
		__subscribe(method(_pwr, function(_is_resolved, _promise_result) {
			
			var _resolve = self.resolve;
			var _reject = self.reject;
			var _callback_subscription = self.callback_subscription;
			var _result;
			
			self.resolve = undefined;
			self.reject = undefined;
			self.callback_subscription = undefined;
			
			try {
				_result = _callback_subscription(_is_resolved, _promise_result);
				_resolve(_result);
			} catch (_error) {
				_reject(_error);
			}
			
		}));
		
		return _next_promise;
		
	}
	
	function on_then(_callback_then) {
		if (ASSERTS_ENABLE) assert(_callback_then, [
			assert_is_callable("[__Promise.on_then] callback_then should be callable")
		]);
		
		var _context = {
			callback_then: _callback_then,
		};
		var _next_promise = on(method(_context, function(_is_resolved, _promise_result) {
			var _callback_then = self.callback_then;
			
			self.callback_then = undefined;
			
			if (_is_resolved) {
				return _callback_then(_promise_result);
			} else {
				throw _promise_result;
			}
		}));
		return _next_promise;
	}
	
	function on_catch(_callback_catch) {
		if (ASSERTS_ENABLE) assert(_callback_catch, [
			assert_is_callable("[__Promise.on_catch] callback_catch should be callable")
		]);
		
		var _context = {
			callback_catch: _callback_catch,
		};
		var _next_promise = on(method(_context, function(_is_resolved, _promise_result) {
			var _callback_catch = self.callback_catch;
			
			self.callback_catch = undefined;
			
			if (_is_resolved) {
				return _promise_result;
			} else {
				return _callback_catch(_promise_result);
			}
		}));
		return _next_promise;
	}
	
	function on_finally(_callback_finally) {
		if (ASSERTS_ENABLE) assert(_callback_finally, [
			assert_is_callable("[__Promise.on_finally] callback_finally should be callable")
		]);
		
		var _context = {
			callback_finally: _callback_finally,
		};
		
		var _next_promise = on(method(_context, function(_is_resolved, _promise_result) {
			var _callback_finally = self.callback_finally;
			
			self.callback_finally = undefined;
			
			_callback_finally();
			
			if (_is_resolved) {
				return _promise_result;
			} else {
				throw _promise_result;
			}
		}));
		
		return _next_promise;
	}
	
	function __is_resolved() {
		return self.__status == __PROMISE_STATUS.RESOLVED;	
	}
	
	function __get_result() {
		return self.__response_result;
	}
	
}

function __promise_loop() {
	static _promise_memory = __PromiseMemory();
	
	var _uncaught_handler = _promise_memory.uncaught_handler;
	var _queue_end = _promise_memory.queue_end;
	var _queue_end_swap = _promise_memory.queue_end_swap;
	var _queue_notifications = _promise_memory.queue_notifications;
	var _queue_notifications_swap = _promise_memory.queue_notifications_swap;
	var _queue_end_size = array_length(_queue_end);
	var _queue_notifications_size = array_length(_queue_notifications);
	var _promise;
	var _notification, _is_resolved, _result, _callback_subscription;
	var i;

	_promise_memory.queue_end = _queue_end_swap;
	_promise_memory.queue_end_swap = _queue_end;
	_promise_memory.queue_notifications = _queue_notifications_swap;
	_promise_memory.queue_notifications_swap = _queue_notifications;
	
	for (i = 0; i < _queue_end_size; ++i) { 
		_promise = array_get(_queue_end, i);
		
		try {
			_promise.__end();
		} catch (_error) {
			if (is_callable(_uncaught_handler)) {
				_uncaught_handler(_error, _promise);
			} else {
				throw _error;
			}
		}
	}
	array_resize(_queue_end, 0);

	for (i = 0; i < _queue_notifications_size; ++i) {
		_notification = array_get(_queue_notifications, i);
		_promise = _notification.promise;
		_is_resolved = _promise.__is_resolved();
		_result = _promise.__get_result();
		_callback_subscription = _notification.callback_subscription;
	
		try {
			_callback_subscription(_is_resolved, _result);
		} catch (_error) {
			if (is_callable(_uncaught_handler)) {
				_uncaught_handler(_error, _promise);
			} else {
				throw _error;
			}
		}
	}
	array_resize(_queue_notifications, 0);
	
}

function is_promise(_value) {
	if (is_struct(_value) and is_instanceof(_value, __Promise)) {
		return true;
	}
	return false;
}

function promise(_handler_init) {
	if (ASSERTS_ENABLE) assert(_handler_init, [
		assert_is_callable("[promise] handler_init should be callable")
	]);
	
	var _promise = new __Promise(_handler_init);
	return _promise;
}

function promise_resolve(_value=undefined) {
	var _context = {
		value: _value,	
	};
	var _promise = new __Promise(method(_context, function(_resolve, _reject) {
		_resolve(self.value);
	}));
	return _promise;
}

function promise_reject(_value) {
	var _context = {
		value: _value,	
	};
	var _promise = new __Promise(method(_context, function(_resolve, _reject) {
		_reject(self.value);
	}));
	return _promise;
}

function promise_all(_promises) {
	if (ASSERTS_ENABLE) assert(_promises, [
		assert_is_array(),
		assert_all_array_item(
			assert_instanceof(__Promise)
		),
	], "[promise_all] promises should be array with promises");
	
	var _promises_size = array_length(_promises);
	if (_promises_size == 0) {
		return promise_resolve([]);
	}
	
	var _clone_array = array_clone_shallow(_promises);
	var _context = {
		size: _promises_size,
		promises: _clone_array,
		resolved_count: 0,
	};
	var _promise = new __Promise(method(_context, function(_resolve, _reject) {
		self.resolve = _resolve;
		self.reject = _reject;
		
		var _promises = self.promises;
		var _promises_size = self.size;
		var _promise, i;
		
		for (i = 0; i < _promises_size; ++i) {
			_promise = array_get(_promises, i);
			_promise.__subscribe(function(_is_resolved, _promise_result) {
				if (false == is_array(self.promises)) {
					return;
				}
				
				if (_is_resolved) {
					self.resolved_count += 1;
					
					if (self.resolved_count == self.size) {
						var _resolve = self.resolve
						var _promises = self.promises;
						var _promises_size = self.size;
						var _promise, _result, i;
						var _values = array_create(_promises_size);
						
						for (i = 0; i < _promises_size; ++i) {
							_promise = array_get(_promises, i);
							_result = _promise.__get_result();
							array_set(_values, i, _result);
						}
						
						self.promises = undefined;
						self.resolve = undefined;
						self.reject = undefined;
						
						_resolve(_values);
					}
				} else {
					var _reject = self.reject;
					
					self.promises = undefined;
					self.resolve = undefined;
					self.reject = undefined;
					
					_reject(_promise_result);
				}
			});
		}
	}));
	return _promise;
}

function promise_any(_promises) {
	if (ASSERTS_ENABLE) assert(_promises, [
		assert_is_array(),
		assert_all_array_item(
			assert_instanceof(__Promise)
		),
	], "[promise_any] promises should be array with promises");
	
	var _promises_size = array_length(_promises);
	if (_promises_size == 0) {
		return promise_reject([]);
	}
	
	var _clone_array = array_clone_shallow(_promises);
	var _context = {
		size: _promises_size,
		promises: _clone_array,
		rejected_count: 0,
	};
	var _promise = new __Promise(method(_context, function(_resolve, _reject) {
		self.resolve = _resolve;
		self.reject = _reject;
		
		var _promises = self.promises;
		var _promises_size = self.size;
		var _promise, i;
		
		for (i = 0; i < _promises_size; ++i) {
			_promise = array_get(_promises, i);
			_promise.__subscribe(function(_is_resolved, _promise_result) {
				if (false == is_array(self.promises)) {
					return;
				}
				
				if (_is_resolved) {
					var _resolve = self.resolve;
					
					self.promises = undefined;
					self.resolve = undefined;
					self.reject = undefined;
					
					_resolve(_promise_result);
					
				} else {
					self.rejected_count += 1;
					
					if (self.rejected_count == self.size) {
						var _reject = self.reject
						var _promises = self.promises;
						var _promises_size = self.size;
						var _promise, _result, i;
						var _values = array_create(_promises_size);
						
						for (i = 0; i < _promises_size; ++i) {
							_promise = array_get(_promises, i);
							_result = _promise.__get_result();
							array_set(_values, i, _result);
						}
						
						self.promises = undefined;
						self.resolve = undefined;
						self.reject = undefined;
						
						_reject(_values);
					}
				}
			});
		}
	}));
	return _promise;
}

function promise_race(_promises) {
	if (ASSERTS_ENABLE) assert(_promises, [
		assert_is_array(),
		assert_all_array_item(
			assert_instanceof(__Promise)
		),
	], "[promise_race] promises should be array with promises");
	
	var _clone_array = array_clone_shallow(_promises);
	var _context = {
		promises: _clone_array,
	};
	var _promise = new __Promise(method(_context, function(_resolve, _reject) {
		self.resolve = _resolve;
		self.reject = _reject;
		
		var _promises = self.promises;
		var _promises_size = array_length(_promises);
		var _promise, i;
		
		for (i = 0; i < _promises_size; ++i) {
			_promise = array_get(_promises, i);
			_promise.__subscribe(function(_is_resolved, _promise_result) {
				if (false == is_array(self.promises)) {
					return;
				}
				
				var _resolve = self.resolve;
				var _reject = self.reject;
				
				self.promises = undefined;
				self.resolve = undefined;
				self.reject = undefined;
				
				if (_is_resolved) {
					_resolve(_promise_result);
				} else {
					_reject(_promise_result);
				}
			});
		}
	}));
	return _promise;
}

function promise_all_settled(_promises) {
	if (ASSERTS_ENABLE) assert(_promises, [
		assert_is_array(),
		assert_all_array_item(
			assert_instanceof(__Promise)
		),
	], "[promise_all_settled] promises should be array with promises");
	
	var _promises_size = array_length(_promises);
	if (_promises_size == 0) {
		return promise_resolve([]);
	}
	
	var _clone_array = array_clone_shallow(_promises);
	var _context = {
		size: _promises_size,
		promises: _clone_array,
		count: 0,
	};
	var _promise = new __Promise(method(_context, function(_resolve) {
		self.resolve = _resolve;
		
		var _promises = self.promises;
		var _promises_size = self.size;
		var _promise, i;
		
		for (i = 0; i < _promises_size; ++i) {
			_promise = array_get(_promises, i);
			_promise.__subscribe(function() {
				if (false == is_array(self.promises)) {
					return;
				}
				
				self.count += 1;
				
				if (self.count == self.size) {
					var _resolve = self.resolve;
					var _promises = self.promises;
					var _promises_size = self.size;
					var _promise, _is_resolved, _result;
					var _values = array_create(_promises_size), _value;
					var i;
					
					for (i = 0; i < _promises_size; ++i) {
						_promise = array_get(_promises, i);
						_is_resolved = _promise.__is_resolved();
						_result = _promise.__get_result();
						
						if (_is_resolved) {
							_value = {
								is_resolved: true,
								result: _result,
							};
						} else {
							_value = {
								is_resolved: false,
								result: _result,
							};
						}
						
						array_set(_values, i, _value);
					}
					
					self.promises = undefined;
					self.resolve = undefined;
					
					_resolve(_values);
				}
			});
		}
	}));
	
	return _promise;
}

function promise_with_resolvers() {
	var _uncontext = {};
	var _promise = new __Promise(method(_uncontext, function(_resolve, _reject) {
		self.resolve = _resolve;
		self.reject = _reject;
	}));
	var _resolve = _uncontext.resolve;
	var _reject = _uncontext.reject;
	
	_uncontext.resolve = undefined;
	_uncontext.reject = undefined;
	
	var _result = {
		promise: _promise,
		resolve: _resolve,
		reject: _reject,
	};
	
	return _result;
}

function promise_get_uncaught_handler() {
	
	return __PromiseMemory().uncaught_handler;
}

function promise_set_uncaught_handler(_handler) {
	if (ASSERTS_ENABLE) assert(_handler, [
		assert_any([
			assert_is_callable()
		], "[promise_set_uncaught_handler] handler should be callable"),
	]);
	
	__PromiseMemory().uncaught_handler = _handler;
}
