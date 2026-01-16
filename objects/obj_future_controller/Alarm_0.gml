
alarm_set(0, 1);

var _future_memory = __FutureMemory();
var _ds_queue_handling = _future_memory.ds_queue_handling;
var _ds_queue_handling_size = ds_queue_size(_ds_queue_handling);

if (_ds_queue_handling_size == 0) {
	return;
}

var _future, _status, _events, _events_size;
var _event, _context;
var _no_reject_subscription;
var i;
repeat (_ds_queue_handling_size) {
	_future = ds_queue_dequeue(_ds_queue_handling);
	_status = _future.__status;
	
	if (_status == __FUTURE_STATUS.CREATED) {
		_context = {
			future: _future,
		};
		
		self.handler_init = _future.__handler_init;
		self.handler_resolve = method(_context, function(_resolved_data) {
			static _ds_queue_handling = __FutureMemory().ds_queue_handling;
			
			var _future = self.future;
			
			self.future = undefined;
			
			if (false == is_struct(_future)) {
				return;
			}
			
			if (is_struct(_resolved_data) and is_instanceof(_resolved_data, __Future)) {
				var _next_future = _resolved_data;
				var _context = {
					future: _future,	
				};
				
				_next_future.once(method(_context, function(_is_resolved, _future_result) {
					static _ds_queue_handling = __FutureMemory().ds_queue_handling;
					
					var _future = self.future;
					
					self.future = undefined;
					
					if (_is_resolved) {
						_future.__status = __FUTURE_STATUS.RESOLVED;
						_future.__response_resolved_data = _future_result;
					} else {
						_future.__status = __FUTURE_STATUS.AWAIT_REJECTED;
						_future.__response_rejected_data = _future_result;
					}

					ds_queue_enqueue(_ds_queue_handling, _future);
					
				}));
			} else {
				_future.__status = __FUTURE_STATUS.RESOLVED;
				_future.__response_resolved_data = _resolved_data;
				
				ds_queue_enqueue(_ds_queue_handling, _future);
			}

		});
		self.handler_reject = method(_context, function(_rejected_data) {
			static _ds_queue_handling = __FutureMemory().ds_queue_handling;
			
			var _future = self.future;
			
			self.future = undefined;
			
			if (false == is_struct(_future)) {
				return;
			}
			
			_future.__status = __FUTURE_STATUS.AWAIT_REJECTED;
			_future.__response_rejected_data = _rejected_data;
			
			ds_queue_enqueue(_ds_queue_handling, _future);
		});
	
		_future.__status = __FUTURE_STATUS.HANDLING;
		_future.__request_init = undefined;
		
		try {
			event_user(0);
		} catch (_error) {
			_future.__status = __FUTURE_STATUS.AWAIT_REJECTED;
			_future.__response_rejected_data = _error;
			
			ds_queue_enqueue(_ds_queue_handling, _future);
		}
		
		self.handler_init = undefined;
		self.handler_resolve = undefined;
		self.handler_reject = undefined;
	} else if (_status == __FUTURE_STATUS.AWAIT_REJECTED) {
		_events = _future.__events;
		_events_size = array_length(_events);
		_no_reject_subscription = true;
		
		for (i = 0; i < _events_size; ++i) {
			_event = array_get(_events, i);
			if (is_callable(_event.reject)) {
				_no_reject_subscription = false;
			}
		}
		
		_future.__status = __FUTURE_STATUS.REJECTED;
		
		ds_queue_enqueue(_ds_queue_handling, _future);
		
		if (_no_reject_subscription) {
			throw _future.__response_rejected_data;
		}
	} else if (_status == __FUTURE_STATUS.RESOLVED || _status == __FUTURE_STATUS.REJECTED) {
		_events = _future.__events;
		_events_size = array_length(_events);
		
		_future.__events = [];
		
		for (i = 0; i < _events_size; ++i) {
			_event = array_get(_events, i);
			
			if (_status == __FUTURE_STATUS.RESOLVED and is_callable(_event.resolve) ) {
				_event.resolve(_future.__response_resolved_data);
			} else if (_status == __FUTURE_STATUS.REJECTED and is_callable(_event.reject) ) {
				_event.reject(_future.__response_rejected_data);
			}
		}
	}
}
