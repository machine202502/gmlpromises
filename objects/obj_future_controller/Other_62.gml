
var _ds_map_async_http = __FutureMemory().ds_map_async_http;
var _request_id = async_load[? "id"];
var _status = async_load[? "status"];
var _context = ds_map_find_value(_ds_map_async_http, _request_id);
var _request_data;
var _resolve, _reject;
var _status_code, _response_data;

if (false == is_struct(_context)) {
	return;
}

_request_data = _context.request;
_resolve = _context.resolve;
_reject = _context.reject;

if (_status < 0) {
	_reject({
		async_status: -1,
		async_request_id: _request_id,
		status_code: undefined,
		response: undefined,
		request: _request_data,
	});
	
	return;
}

_status_code = async_load[? "http_status"];
_response_data = async_load[? "result"];

if (_status_code >= 400) {
	_reject({
		async_status: 0,
		async_request_id: _request_id,
		status_code: _status_code,
		response: _response_data,
		request: _request_data,
	});
	
	return;
}

_resolve({
	async_status: 0,
	async_request_id: _request_id,
	status_code: _status_code,
	response: _response_data,
	request: _request_data,
});
