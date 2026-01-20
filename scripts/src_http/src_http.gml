
function http_query_param(_key, _values) {
	if (ASSERTS_ENABLE) assert(_key, [
		assert_is_string(),
		assert_string_length_compare(">", 0),
	], "[http_query_param] key should be string");
	if (ASSERTS_ENABLE) assert(_values, [
		assert_is_array(),
		assert_all_array_item(assert_all([
			assert_is_string(),
			assert_string_length_compare(">", 0),
		]))
	], "[http_query_param] values should be string[]");
	
	var _values_size = array_length(_values);
	var _value;
	var i;
	var _string = "";
	
	for (i = 0; i < _values_size; ++i) {
		_value = array_get(_values, i);
		
		if (i > 0) {
			_string += "&";
		}
		_string += _key + "=" + _value;
	}
	
	return _string;
}
