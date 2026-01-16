
function __GlobalEventEmitterMemory() {
	
	static _memory = {};
	return _memory
	
}

/// @param {String} [_name]
/// @return {Struct.EventEmitter}
function GlobalEventEmitter(_name = "default") {
	
	static _memory = __GlobalEventEmitterMemory()
	
	var _emitter = struct_get(_memory, _name);
	if (is_struct(_emitter)) {
		return _emitter;
	}
	
	_emitter = new EventEmitter();
	struct_set(_memory, _name, _emitter);
	
	return _emitter;
	
}
