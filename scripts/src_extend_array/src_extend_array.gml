
function extend_array_clone_shallow(_array) {
	var _length = array_length(_array);
	var _clone = array_create(_length);
	
	array_copy(_clone, 0, _array, 0, _length);
	return _clone;
}

function extend_array_join(_array, _separator=",") {
	var _array_size = array_length(_array);
	var _value;
	var _result = "";
	var i;
	for (i = 0; i < _array_size; i++) {
		_value = array_get(_array, i);
		
		if (i > 0) {
			_result += _separator;
		}
		_result += string(_value);
	}
	return _result;
}
