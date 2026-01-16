
function async_timeout(_ms, _data = undefined) {
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
			self.resolve(self.data);
		}));
		time_source_start(_timesource);
	}));
	return _future;
}
