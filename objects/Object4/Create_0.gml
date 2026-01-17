alarm_set(0, 180);

function get_http(_url) {
	var _context = {
		url: _url,	
	};
	var _future = future(method(_context, function(_resolve, _reject) {
		self.resolve = _resolve;
		self.reject = _reject;
		
		var _future = async_http_request(self.url, "get", {}, 1).once(function(_resolved, _rejected) {
			
			if (_rejected) {
				self.reject({
					status_code: _rejected.status_code,
					response: _rejected.response,
				});
				
				return;
			}
			
			if (_resolved) {
				self.resolve({
					status_code: _resolved.status_code,
					response: _resolved.response,
				});
				
				return;
			}
		});
	}));
	return _future;
}

function get_http_simpled(_url) {
	var _future = async_http_request(_url, "get")
		.on_then(function(_resolved) {
			return {
				status_code: _resolved.status_code,
				response: _resolved.response,
			}
		})
		.on_then(function(_resolved) {
			return future_reject({
				code: _resolved.status_code,
				response: _resolved.response,
			});
		})
		.on_catch(function(_rejected) {
			return _rejected; 
		})
		.on_then(function(_resolved) {
			return async_timeout(1500, _resolved);
		})
		.on_finally(function() {
			show_debug_message("oco");
		})
		
	return _future;
}
