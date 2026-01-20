
function __network_manager_async_http_request(_url, _method="get", _headers=undefined, _body=undefined) {
	
	var _future = async_http_request(_url, _method, _headers, _body)
		.on(function(_is_resolved, _result) {
			var _status = _result.status_code;
			var _json_string = _result.response;
			var _json = json_parse(_json_string);
			
			_result.response = _json;
			
			if (_is_resolved and false == _json.isError) {
				return _json.details;
			} else {
				throw _result;
			}
		})
	
	return _future;
	
}

function network_manager_ping() {
	static _url = string_concat(
		env("manager_url"),
		"ping"
	);
	
	var _future = async_http_request(_url, "get")
		.on_then(function(_result) {
			if (_result.response == "pong") {
				return true;
			}
			
			throw ({
				message: "response should be pong",
			});
		});
	
	return _future;
	
}

function network_manager_settings(_keys=undefined) {
	if (ASSERTS_ENABLE) assert(_keys, [
		assert_any([
			assert_is_undefined(),
			assert_all([
				assert_is_array(),
				assert_all_array_item(assert_all([
					assert_is_string(),
					assert_string_length_compare(">", 0),
				])),
			])
		])
	], "[network_manager_settings] keys should be void or string[]");
	
	static _base_url = string_concat(
		env("manager_url"),
		"settings/v1"
	);
	
	var _url = _base_url;
	
	if (is_array(_keys) and array_length(_keys)) {
		_url = _base_url + "?" + http_query_param("keys", _keys);
	}
	
	var _future = __network_manager_async_http_request(_url, "get")
		.on_then(function(_data) {
			var _settings = _data.settings;
			var _object = {};
			
			array_foreach(_settings, method(_object, function(_setting) {
				var _parsed = __network_manager_setting_parse(_setting);
				struct_set(self, _parsed.name, _parsed.value);
			}));
			
			return _object;
		});
	
	return _future;
}

function network_manager_setting(_key) {
	if (ASSERTS_ENABLE) assert(_key, [
		assert_is_string(),
		assert_string_length_compare(">", 0),
	], "[network_manager_setting] key should be string");
	
	static _base_url = string_concat(
		env("manager_url"),
		"settings/v1"
	);
	
	var _url = _base_url + "/" + _key;
	
	var _future = __network_manager_async_http_request(_url, "get")
		.on_then(function(_data) {
			var _setting = _data.setting;
			var _parsed = __network_manager_setting_parse(_setting);
			return _parsed.value;
		});
	
	return _future;
}

function __network_manager_setting_parse(_setting) {
	var _key = _setting.key;
	var _value = _setting.value;
	var _metadata = _setting.metadata;
	
	if (_metadata == "number") {
		_value = real(_value);
	} else if (_metadata == "json") {
		_value = json_parse(_value);
	}
	
	var _parsed = {
		name: _key,
		value: _value,
	};
	
	return _parsed;
	
}
