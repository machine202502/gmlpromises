
show_debug_message("Space pressed");

var _message = {
	"text": "Invoker"
};
var _json = json_stringify(_message);

var _buffer = buffer_create(string_length(_json) + 1, buffer_grow, 1);
buffer_write(_buffer, buffer_string, _json);
network_send_raw(self.socket, _buffer, buffer_tell(_buffer));
buffer_delete(_buffer);
