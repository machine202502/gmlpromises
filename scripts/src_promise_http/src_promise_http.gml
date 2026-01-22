
function async_http_request(_url, _method="get", _body=undefined, _headers=undefined) {
	if (ASSERTS_ENABLE) assert(_url, [
		assert_is_string("[async_http_request] url should be string"),
	]);
	if (ASSERTS_ENABLE) assert(_method, [
		assert_is_string("[async_http_request] method should be string"),
		assert_in([
			"GET", "HEAD", "POST", "PUT", "DELETE", "TRACE", "OPTIONS", "CONNECT",
			"get", "head", "post", "put", "delete", "trace", "options", "connect"
		], "[async_http_request] method must be one of: GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS, CONNECT"),
	]);
	if (ASSERTS_ENABLE) assert(_body, [
		assert_any([
			assert_is_undefined(),
			assert_is_string(),
			assert_is_struct(),
			assert_all([
				assert_is_numeric(),
				assert_buffer_exists(),
			])
		], "[async_http_request] body must be void, string, json, or buffer"),
	]);
	if (ASSERTS_ENABLE) assert(_headers, [
		assert_any([
			assert_is_undefined(),
			assert_is_struct(),
		], "[async_http_request] headers should be void or json"),
	]);
	
	var _context = {
		url: _url,
		method: _method,
		headers: _headers,
		body: _body,
	};
	var _promise = promise(method(_context, function(_resolve, _reject) {
		static _ds_map_async_http = __PromiseMemory().ds_map_async_http;
		static _ds_map_headers = __PromiseMemory().ds_map_headers;
		
		var _url = self.url;
		var _method = self.method ?? "get";
		var _headers = self.headers ?? {};
		var _body = self.body ?? {};
		var _async_request_id;
		var _request;
		
		self.headers = undefined;
		self.body = undefined;
	
		_method = string_upper(_method);
	
		if (is_struct(_body)) {
			_body = json_stringify(_body);
		}
		
		_request = {
			url: _url,
			method: _method,
			headers: is_struct(_headers) ? weak_ref_create(_headers) : _headers,
			body: is_struct(_body) ? weak_ref_create(_body) : _body,
		};
	
		struct_foreach(_headers, function(_name, _value) {
			static _ds_map_headers = __PromiseMemory().ds_map_headers;
			
			ds_map_set(_ds_map_headers, _name, _value);
		});
		
		_async_request_id = http_request(_url, _method, _ds_map_headers, _body);
		
		ds_map_clear(_ds_map_headers);
		
		if (_async_request_id == -1) {
			throw ({
				message: "error create http request",
				request: _request, 
			});
		}
		
		ds_map_set(_ds_map_async_http, _async_request_id, {
			request: _request,
			resolve: _resolve,
			reject: _reject,
		});
	}));
	return _promise;
}
