
function __GlobalEventorMemory() {
	
	static _memory = {};
	return _memory
	
}

/// @param {String} [_name]
/// @return {Struct.EventEmitter}
function GlobalEventor(_name = "default") {
	
	static _memory = __GlobalEventorMemory()
	
	var _emitter = struct_get(_memory, _name);
	if (is_struct(_emitter)) {
		return _emitter;
	}
	
	_emitter = new Eventor();
	struct_set(_memory, _name, _emitter);
	
	return _emitter;
	
}
