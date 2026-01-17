
function async_timeout(_ms, _data = undefined) {
	if (ASSERTS_ENABLE) assert(_ms, [
		assert_is_numeric("[async_timeout] ms should be number"),
		assert_gte(0, "[async_timeout] ms should be 0 or more"),
	]);
	
	var _context = {
		ms: _ms,
		data: _data,
	};
	var _future = future(method(_context, function(_resolve, _reject) {
		var _ms = self.ms;
		var _data = self.data;
		var _seconds = _ms / 1000;
		var _context = {
			resolve: _resolve,
			data: _data,
		};
		var _timesource = time_source_create(time_source_game, _seconds, time_source_units_seconds, method(_context, function() {
			var _resolve = self.resolve;
			var _data = self.data;
			
			self.resolve = undefined;
			self.data = undefined;
			
			time_source_destroy(self.timesource);
			
			_resolve(_data);
		}));
		
		_context.timesource = _timesource;
		time_source_start(_timesource);
	}));
	return _future;
}

function async_frameout(_frames, _data = undefined) {
	if (ASSERTS_ENABLE) assert(_frames, [
		assert_is_numeric("[async_frameout] frames should be number"),
		assert_gte(0, "[async_frameout] frames should be 0 or more"),
	]);
	
	var _context = {
		frames: _frames,
		data: _data,
	};
	var _future = future(method(_context, function(_resolve, _reject) {
		var _frames = self.frames;
		var _data = self.data;
		var _context = {
			resolve: _resolve,
			data: _data,
		};
		var _timesource = time_source_create(time_source_game, _frames, time_source_units_frames, method(_context, function() {
			var _resolve = self.resolve;
			var _data = self.data;
			
			self.resolve = undefined;
			self.data = undefined;
			
			time_source_destroy(self.timesource);
			
			_resolve(_data);
		}));
		
		_context.timesource = _timesource;
		time_source_start(_timesource);
	}));
	return _future;
}
