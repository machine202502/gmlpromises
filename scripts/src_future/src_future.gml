
enum __FUTURE_STATUS {
	CREATED,
	HANDLING,
	AWAIT_REJECTED,
	RESOLVED,
	REJECTED,
}

function __FutureMemory() {
	
	static _memory = (function() {
		
		var _ds_queue_handling = ds_queue_create();
		var _ds_map_async_http = ds_map_create();
		var _ds_map_headers = ds_map_create();
		var _memory = {
			ds_queue_handling: _ds_queue_handling,
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
		self.__status = __FUTURE_STATUS.CREATED;
		self.__handler_init = _handler_init;
		self.__response_resolved_data = undefined;
		self.__response_rejected_data = undefined;
		self.__events = [];
	}
	#endregion
	
	function __run() {
		var _future_memory = __FutureMemory(); 
		var _tail = ds_queue_tail(_future_memory.ds_queue_handling);
		if (_tail != self) {
			ds_queue_enqueue(_future_memory.ds_queue_handling, self);
		}
	}
	
	function __subscribe(_callback_resolve=undefined, _callback_reject = undefined) {
		
		var _event = {
			resolve: _callback_resolve,
			reject: _callback_reject,
		};
		
		array_push(self.__events, _event);
	}
	
	function once(_callback_subscription) {
		
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
		__run();
		
	}
	
	function pipe(_callback_subscription) {
		var _self = self;
		var _context = {
			first_future: _self,
			callback_subscription: _callback_subscription,	
		};
		var _second_future = new __Future(method(_context, function(_resolve, _reject) {
			self.resolve = _resolve;
			self.reject = _reject;
			
			self.first_future.once(function(_is_resolved, _future_result) {
				var _resolve = self.resolve;
				var _reject = self.reject;
				var _callback_subscription = self.callback_subscription;
				
				self.resolve = undefined;
				self.reject = undefined;
				self.first_future = undefined;
				self.callback_subscription = undefined;
				
				if (_is_resolved) {
					try {
						var _result = _callback_subscription(_is_resolved, _future_result);
						_resolve(_result);
					} catch (_error) {
						_reject(_error);
					}
				} else {
					try {
						var _result = _callback_subscription(_is_resolved, _future_result);
						_resolve(_result);
					} catch (_error) {
						_reject(_error);
					}
				}
				
			});
		}));
		
		_second_future.__run();
		return _second_future;
	}
	
	function on_then(_callback_then) {
		var _context = {
			callback_then: _callback_then,
		};
		var _future = pipe(method(_context, function(_is_resolved, _future_result) {
			var _callback_then = self.callback_then;
			
			self.callback_then = undefined;
			
			if (_is_resolved) {
				return _callback_then(_future_result);
			} else {
				throw _future_result;
			}
		}));
		return _future;
	}
	
	function on_catch(_callback_catch) {
		var _context = {
			callback_catch: _callback_catch,
		};
		var _future = pipe(method(_context, function(_is_resolved, _future_result) {
			var _callback_catch = self.callback_catch;
			
			self.callback_catch = undefined;
			
			if (_is_resolved) {
				return _future_result;
			} else {
				return _callback_catch(_future_result);
			}
		}));
		return _future;
	}
	
	function on_finally(_callback_finally) {
		var _context = {
			callback_finally: _callback_finally,
		};
		var _future = pipe(function(_is_resolved, _future_result) {
			if (_is_resolved) {
				return _future_result;
			} else {
				throw _future_result;
			}
		});
		
		_future.once(method(_context, function(_is_resolved, _future_result) {
			var _callback_finally = self.callback_finally;
			
			self.callback_finally = undefined;
			
			_callback_finally(_is_resolved, _future_result);
		}));
		
		return _future;
	}
	
}

function future(_handler_init) {
	var _future = new __Future(_handler_init);
	_future.__run();
	return _future;
}

function future_resolve(_value) {
	var _context = {
		value: _value,	
	};
	var _future = new __Future(method(_context, function(_resolve, _reject) {
		_resolve(self.value);
	}));
	_future.__run();
	return _future;
}

function future_reject(_value) {
	var _context = {
		value: _value,	
	};
	var _future = new __Future(method(_context, function(_resolve, _reject) {
		_reject(self.value);
	}));
	_future.__run();
	return _future;
}

function future_all(_futures) {
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
							_value = _future.__response_resolved_data;
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
	_future.__run();
	return _future;
}

function future_any(_futures) {
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
							_value = _future.__response_rejected_data;
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
	_future.__run();
	return _future;
}

function future_race(_futures) {
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
	_future.__run();
	return _future;
}

function future_all_settled(_futures) {
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
					var _future, _value, _is_resolved, i;
					var _values = array_create(_futures_size);
					
					for (i = 0; i < _futures_size; ++i) {
						_future = array_get(_futures, i);
						_is_resolved =  _future.__status == __FUTURE_STATUS.RESOLVED;
						_value = _is_resolved
							? _future.__response_resolved_data 
							: _future.__response_rejected_data;
						array_set(_values, i, {
							is_resolved: _is_resolved,
							result: _value,
						});
					}
					
					self.futures = undefined;
					self.resolve = undefined;
					
					_resolve(_values);
				}
			});
		}
	}));
	_future.__run();
	return _future;
}

function future_with_resolvers() {
	var _context = {
		trigger_future: undefined,
		trigger_resolve: undefined,
		future_argument: undefined,
		future_resolve: undefined,
		future_reject: undefined,
		future: undefined,
	};
	var _future_trigger = new __Future(method(_context, function(_resolve) {
		
		var _future = new __Future(function(_resolve, _reject) {
			self.future_resolve = _resolve;
			self.future_reject = _reject;
			
			var _trigger_resolve = self.trigger_resolve;
			
			self.trigger_resolve = undefined;
			
			_trigger_resolve();
		});
		
		self.trigger_resolve = _resolve;
		self.future = _future;
		
		_future.__run();
	}));
	var _future = _future_trigger.pipe(method(_context, function() {
		var _future = self.future;
		
		self.future = undefined;
		
		return _future;
	}));
	var _resolve = method(_context, function(_resolved) {
		if (is_struct(self.trigger_future)) {
			self.future_argument = _resolved;
			
			var _trigger_future = self.trigger_future;
			
			self.trigger_future = undefined;
			
			_trigger_future.once(function() {
				if (is_callable(self.future_resolve)) {
					var _future_resolve = self.future_resolve;
					var _future_argument = self.future_argument;
					
					self.future_argument = undefined;
					self.future_resolve = undefined;
					self.future_reject = undefined;
					
					_future_resolve(_future_argument);
				}
			});
		}
	});
	var _reject = method(_context, function(_rejected) {
		if (is_struct(self.trigger_future)) {
			self.future_argument = _rejected;
			
			var _trigger_future = self.trigger_future;
			
			self.trigger_future = undefined;
			
			_trigger_future.once(function() {
				if (is_callable(self.future_reject)) {
					var _future_reject = self.future_reject;
					var _future_argument = self.future_argument;
					
					self.future_argument = undefined;
					self.future_resolve = undefined;
					self.future_reject = undefined;
					
					_future_reject(_future_argument);
				}
			});
		}
	});
	
	_context.trigger_future = _future_trigger;
	
	var _result = {
		future: _future,
		resolve: _resolve,
		reject: _reject,
	};
	
	_future_trigger.__run();
	return _result;
}

