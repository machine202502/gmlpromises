
alarm_set(0, 1);

var _ds_queue_handling = __FutureMemory().ds_queue_handling;
var _uncaught_handler = __FutureMemory().uncaught_handler;
var _futures = ds_map_keys_to_array(_ds_queue_handling);
var _futures_size = ds_map_size(_ds_queue_handling);
var _future, _status;
var _event, _events, _events_size;
var _no_reject_subscription;
var f, i;

if (_futures_size == 0) {
	return;
}

ds_map_clear(_ds_queue_handling);

for (f = 0; f < _futures_size; ++f) {
	_future = array_get(_futures, f);
	_status = _future.__status;
	
	if (_status == __FUTURE_STATUS.REJECTING) {
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
		_future.__run();
		
		if (_no_reject_subscription) {
			if (is_callable(_uncaught_handler)) {
				_uncaught_handler(_future.__response_rejected_data);
			} else {
				throw _future.__response_rejected_data;
			}
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
