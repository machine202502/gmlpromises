var _type = async_load[? "type"];

if (_type == network_type_data) {
	var _buffer = async_load[? "buffer"];
	buffer_seek(_buffer, buffer_seek_start, 0);
	var _content = buffer_read(_buffer, buffer_string);
	
	show_debug_message(_content);
}
