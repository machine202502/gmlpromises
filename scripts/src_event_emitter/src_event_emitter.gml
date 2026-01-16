
/* You need control memory leak */

function EventEmitter() constructor {
	
	#region __constructor
	{
		self.__events = {};
	}
	#endregion
	
	function on(_event_name, _callback, _callback_id=other) {
		var _event = {
			id: _callback_id ?? _callback,
			callback: _callback,
		};
		
		var _events = struct_get(self.__events, _event_name) ?? [];
		struct_set(self.__events, _event_name, _events);
		
		array_push(_events, _event);
		
		return self;
	}
	
	function off(_event_name_or_callback_id=other, _callback_or_callback_id=other) {
		if (!is_string(_event_name_or_callback_id)) {
			var _keys = struct_get_names(self.__events);
			var _size = array_length(_keys);
			
			var _key;
			for (var i = 0; i < _size; ++i) {
				_key = _keys[i];
				
				self.off(_key, _event_name_or_callback_id);
			}
			
			return self;
		}
		
		var _events = struct_get(self.__events, _event_name_or_callback_id);
		
		if (!is_array(_events)) {
			return self;
		}
		
		if (is_undefined(_callback_or_callback_id)) {
			struct_remove(self.__events, _event_name_or_callback_id);
			return self;
		}
		
		var _event;
		for (var i = array_length(_events) - 1; i >= 0; --i) {
			_event = _events[i];
			
			if (
				_event.id == _callback_or_callback_id ||
				_event.callback == _callback_or_callback_id
			) {
				array_delete(_events, i, 1);
			}
		}
		
		if (array_length(_events) == 0) {
			struct_remove(self.__events, _event_name_or_callback_id);
			return self;
		}
		
		return self;
	}
	
	function emit(_event_name, _value=undefined) {
		var _events = struct_get(self.__events, _event_name);
		
		if (!is_array(_events)) {
			return self;
		}
		
		var _size = array_length(_events);
		var _using_events = _events;
		
		var _event;
		for (var i = 0; i < _size; ++i) {
			_event = _using_events[i];
			_event.callback(_value, {
				id: _event.id,
				callback: _event.callback,
			});
		}
		
		return self;
	}
	
	function listeners_count(_event_name=undefined) {
		
		if (is_string(_event_name)) {
			var _events = struct_get(self.__events, _event_name) ?? [];
			var _count = array_length(_events);
			return _count;
		}
		
		var _context = {
			count: 0,
		}
		
		struct_foreach(self.__events, method(_context, function(_listeners) {
			if (!is_array(_listeners)) {
				return;
			}
			
			self.count += array_length(_listeners);
		}));
		
		return _context.count;
	}

}
