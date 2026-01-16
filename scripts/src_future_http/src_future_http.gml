
function async_http_request(_url, _method="get", _headers=undefined, _body=undefined) {
	var _context = {
		url: _url,
		method: _method,
		headers: _headers,
		body: _body,
	};
	var _future = future(method(_context, function(_resolve, _reject) {
		static _ds_map_async_http = __FutureMemory().ds_map_async_http;
		static _ds_map_headers = __FutureMemory().ds_map_headers;
		
		var _url = self.url;
		var _method = self.method ?? "get";
		var _headers = self.headers ?? {};
		var _body = self.body ?? {};
	
		_method = string_upper(_method);
	
		if (is_struct(_body)) {
			_body = json_stringify(_body);
		}
	
		ds_map_clear(_ds_map_headers);
	
	
		struct_foreach(_headers, function(_name, _value) {
			static _ds_map_headers = __FutureMemory().ds_map_headers;
			
			ds_map_set(_ds_map_headers, _name, _value);
		});

		var _async_request_id = http_request(_url, _method, _ds_map_headers, _body);
	
		if (_async_request_id == -1) {
			throw ({
				message: "error create http request",
				request: self, 
			});
		}
	
		ds_map_set(_ds_map_async_http, _async_request_id, {
			request: self,
			resolve: _resolve,
			reject: _reject,
		});
	}));
	return _future;
}
