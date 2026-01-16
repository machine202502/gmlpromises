
function extend_array_clone_shallow(_array) {
	var _length = array_length(_array);
	var _clone = array_create(_length);
	
	array_copy(_clone, 0, _array, 0, _length);
	return _clone;
}
