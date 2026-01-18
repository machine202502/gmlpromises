
alarm_set(0, 1);

var _uncaught_handler = self.future_memory.uncaught_handler;
var _queue_finishing = self.future_memory.queue_finishing;
var _queue_finishing_swap = self.future_memory.queue_finishing_swap;
var _queue_notifications = self.future_memory.queue_notifications;
var _queue_notifications_swap = self.future_memory.queue_notifications_swap;
var _queue_finishing_size = array_length(_queue_finishing);
var _queue_notifications_size = array_length(_queue_notifications);
var _future;
var _finished_without_subscriptions, _rejecting_without_subscriptions;
var _notification;
var _resolve, _reject;
var _is_resolved, _result;
var i;

self.future_memory.queue_finishing = _queue_finishing_swap;
self.future_memory.queue_finishing_swap = _queue_finishing;
self.future_memory.queue_notifications = _queue_notifications_swap;
self.future_memory.queue_notifications_swap = _queue_notifications;

for (i = 0; i < _queue_finishing_size; ++i) {
	_future = array_get(_queue_finishing, i);
	_finished_without_subscriptions = _future.__finished();
	_is_resolved = _future.__is_resolved();
	_result = _future.__get_result();
	_rejecting_without_subscriptions 
		= false == _is_resolved and _finished_without_subscriptions; 
	
	if (_rejecting_without_subscriptions) {
		if (is_callable(_uncaught_handler)) {
			_uncaught_handler(_result);
		} else {
			throw _result;
		}
	}
}
array_resize(_queue_finishing, 0);

for (i = 0; i < _queue_notifications_size; ++i) {
	_notification = array_get(_queue_notifications, i);
	_future = _notification.future;
	_resolve = _notification.resolve;
	_reject = _notification.reject;
	_is_resolved = _future.__is_resolved();
	_result = _future.__get_result();
	
	try {
		if (_is_resolved) {
			_resolve(_result);
		} else {
			_reject(_result);
		}
	} catch (_error) {
		if (is_callable(_uncaught_handler)) {
			_uncaught_handler(_error);
		} else {
			throw _error;
		}
	}
}
array_resize(_queue_notifications, 0);
