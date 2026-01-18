
function uuid() {
	static _array = array_create(16);
	static _buffer = buffer_create(32, buffer_fixed, 1);
	static _string = "0123456789abcdef";
	static _separator = ord("-");
	
    var i;
	var _v, _a, _b;
   
	for (i = 0; i < 16; ++i) {
        _array[i] = (irandom(255) + current_time) mod 256;
    }
	
    _array[6] = (_array[6] & $0F) | $40;
    _array[8] = (_array[8] & $3F) | $80;
	
	buffer_seek(_buffer, buffer_seek_start, 0);
    for (i = 0; i < 16; ++i) {
        _v = _array[i];
		_a = string_ord_at(_string, (_v >> 4) + 1);
		_b = string_ord_at(_string, (_v & $0F) + 1);
		
		buffer_write(_buffer, buffer_u8, _a);
		buffer_write(_buffer, buffer_u8, _b);
		
        if (i == 3 || i == 5 || i == 7 || i == 9) {
			buffer_write(_buffer, buffer_u8, _separator);
		}
    }
	
	buffer_seek(_buffer, buffer_seek_start, 0);
    return buffer_read(_buffer, buffer_string);
}
