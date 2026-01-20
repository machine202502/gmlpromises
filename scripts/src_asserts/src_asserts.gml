
#macro ASSERTS_ENABLE true

function assert(_argument, _asserts, _message=undefined) {
	if (ASSERTS_ENABLE) {
		
		var _assert = assert_all(_asserts, _message);
		
		try {
			_assert(_argument);	
		} catch (_error) {
			
			var _mapped_error = {
				message: _error.message,
				details: _error,
			};
			
			struct_remove(_error, "message");
			
			show_debug_message(json_stringify(_mapped_error, true));
			
			throw (_mapped_error);
		}
		
	}
}

function __assert_type_factory(_type, _message=undefined) {
	if (ASSERTS_ENABLE) {
		
		var _context = {
			type: _type,
			message: _message,
		};
		var _callback = method(_context, function(_value) {
			
			var _type = typeof(_value);
			var _equals = _type == self.type;
			
			if (false == _equals) {
				throw ({
					message: self.message ?? "__assert_type_factory",
				});
			}
			
		});
		
		return _callback;
		
	}
}

function assert_type_bool(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_type_factory("bool", _message);
		
	}
}

function assert_type_string(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_type_factory("string", _message);
		
	}
}

function assert_type_number(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_type_factory("number", _message);
		
	}
}

function assert_type_array(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_type_factory("array", _message);
		
	}
}

function assert_type_int32(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_type_factory("int32", _message);
		
	}
}

function assert_type_int64(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_type_factory("int64", _message);
		
	}
}

function assert_type_ptr(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_type_factory("ptr", _message);
		
	}
}

function assert_type_undefined(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_type_factory("undefined", _message);
		
	}
}

function assert_type_null(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_type_factory("null", _message);
		
	}
}

function assert_type_method(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_type_factory("method", _message);
		
	}
}

function assert_type_struct(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_type_factory("struct", _message);
		
	}
}

function assert_type_ref(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_type_factory("ref", _message);
		
	}
}

function __assert_is_kind_factory(_fn_when_check_kind, _message=undefined) {
	if (ASSERTS_ENABLE) {
		
		var _context = {
			fn_when_check_kind: _fn_when_check_kind,
			message: _message,
		};
		var _callback = method(_context, function(_value) {
			
			var _equals = self.fn_when_check_kind(_value);
			
			if (false == _equals) {
				throw ({
					message: self.message ?? "__assert_is_kind_factory",
				});
			}
			
		});
		
		return _callback;
		
	}
}

function assert_is_string(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_string, _message);
		
	}
}

function assert_is_real(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_real, _message);
		
	}
}

function assert_is_numeric(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_numeric, _message);
		
	}
}

function assert_is_bool(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_bool, _message);
		
	}
}

function assert_is_array(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_array, _message);
		
	}
}

function assert_is_struct(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_struct, _message);
		
	}
}

function assert_is_method(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_method, _message);
		
	}
}

function assert_is_callable(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_callable, _message);
		
	}
}

function assert_is_ptr(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_ptr, _message);
		
	}
}

function assert_is_int32(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_int32, _message);
		
	}
}

function assert_is_int64(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_int64, _message);
		
	}
}

function assert_is_undefined(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_undefined, _message);
		
	}
}

function assert_is_nan(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_nan, _message);
		
	}
}

function assert_is_infinity(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_infinity, _message);
		
	}
}

function assert_is_handle(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		return __assert_is_kind_factory(is_handle, _message);
		
	}
}

function assert_all(_asserts, _message=undefined) {
	if (ASSERTS_ENABLE) {
		
		if (false == is_array(_asserts)) {
			throw ({
				message: "ASSERTS_BAD_CONTSUCTOR_ARGUMENTS",
			});
		}
		
		var _context = {
			asserts: _asserts,
			message: _message,
		};
		var _callback = method(_context, function(_value) {
			var i;
			var _asserts = self.asserts;
			var _asserts_size = array_length(_asserts);
			var _errors = [];
			var _assert;
			for (i = 0; i < _asserts_size; ++i) {
				_assert = array_get(_asserts, i);
			
				try {
					_assert(_value);
				} catch (_error) {
					array_push(_errors, _error);
				}
			}
		
			if (array_length(_errors) > 0) {
				throw ({
					message: self.message ?? _errors[0].message,
					causes: _errors,
				});
			}
		
		});
		
		return _callback;
		
	}
}

function assert_any(_asserts, _message=undefined) {
	if (ASSERTS_ENABLE) {
		
		if (false == is_array(_asserts)) {
			throw ({
				message: "ASSERTS_BAD_CONTSUCTOR_ARGUMENTS",
			});
		}
		
		var _asserts_size = array_length(_asserts);
		if (0 == _asserts_size) {
			throw ({
				message: "ASSERTS_BAD_CONTSUCTOR_ARGUMENTS",
			});
		}
		
		var _context = {
			asserts: _asserts,
			message: _message,
		};
		var _callback = method(_context, function(_value) {
			var i;
			var _asserts = self.asserts;
			var _asserts_size = array_length(_asserts);
			var _errors = [];
			var _assert;
			for (i = 0; i < _asserts_size; ++i) {
				_assert = array_get(_asserts, i);
			
				try {
					_assert(_value);
					return;
				} catch (_error) {
					array_push(_errors, _error);
				}
			}
		
			if (array_length(_errors) > 0) {
				throw ({
					message: self.message ?? _errors[0].message,
					causes: _errors,
				});
			}
		
		});
		
		return _callback;
		
	}
}

function assert_instanceof(_constructor, _message=undefined) {
	if (ASSERTS_ENABLE) {
		
		var _context = {
			construct: _constructor,
			message: _message
		};
		var _callback = method(_context, function(_value) {
			
			if (false == is_struct(_value) or false == is_instanceof(_value, self.construct)) {
				throw ({
					message: self.message ?? "assert_instanceof",
				});
			}
			
		});
		
		return _callback;
		
	}
}

function assert_all_array_item(_callback_assert, _message=undefined) {
	if (ASSERTS_ENABLE) {
		
		var _context = {
			callback_assert: _callback_assert,
			message: _message,
		};
		var _callback = method(_context, function(_array) {
			
			var _size = array_length(_array);
			var _item;
			var i;
			for (i = 0; i < _size; ++i) {
				_item = array_get(_array, i);
				
				try {
					self.callback_assert(_item);
				} catch (_error) {
					throw ({
						message: self.message ?? _error.message, 
						index: i,
						cause: _error,
					});
				}
			}
			
		});
		
		return _callback;
		
	}
}

function assert_in(_values, _message=undefined) {
	if (ASSERTS_ENABLE) {
		
		if (false == is_array(_values)) {
			throw ({
				message: "ASSERTS_BAD_CONTSUCTOR_ARGUMENTS",
			});
		}
		if (0 == array_length(_values)) {
			throw ({
				message: "ASSERTS_BAD_CONTSUCTOR_ARGUMENTS",
			});
		}
		
		var _context = {
			values: _values,
			message: _message,
		};
		var _callback = method(_context, function(_value) {
			var _array = self.values;
			var _array_size = array_length(_array);
			var _item, i;
			
			for (i = 0; i < _array_size; ++i) {
				_item = array_get(_array, i);
				if (_item == _value) {
					return;	
				}
			}
			
			throw ({
				message: self.message ?? "assert_in", 
				value: _value,
				values: self.values,
			});
		});
		
		return _callback;
		
	}
}

function assert_ds_exists(_ds_type, _message=undefined) {
	if (ASSERTS_ENABLE) {
		
		var _context = {
			ds_type: _ds_type,
			message: _message,
		};
		var _callback = method(_context, function(_value) {
			
			if (false == ds_exists(_value, self.ds_type)) {
				throw ({
					message: self.message ?? "assert_ds_exists", 
				});
			}
		});
		
		return _callback;
		
	}
}

function assert_buffer_exists(_message=undefined) {
	if (ASSERTS_ENABLE) {
		
		var _context = {
			message: _message,
		};
		var _callback = method(_context, function(_value) {
			
			if (false == buffer_exists(_value)) {
				throw ({
					message: self.message ?? "assert_buffer_exists", 
				});
			}
		});
		
		return _callback;
		
	}
}

function assert_string_length_compare(_operator, _rval, _message=undefined) {
	if (ASSERTS_ENABLE) {
		
		if (false == array_contains(["==", ">=", "<=", "<", ">", "!="], _operator)) {
			throw ({
				message: "ASSERTS_BAD_CONTSUCTOR_ARGUMENTS",
			});
		}
		
		var _context = {
			rval: _rval,
			operator: _operator,
			message: _message,
		};
		var _callback = method(_context, function(_string) {
			var _operator = self.operator;
			var _rval = self.rval;
			var _lval = string_length(_string);
			var _operator_compared_result;
			
			if (_operator == "==") {
				_operator_compared_result = _lval == _rval;
			} else if (_operator == ">=") {
				_operator_compared_result = _lval >= _rval;
			} else if (_operator == "<=") {
				_operator_compared_result = _lval <= _rval;
			} else if (_operator == ">") {
				_operator_compared_result = _lval > _rval;
			} else if (_operator == "<") {
				_operator_compared_result = _lval < _rval;
			} else if (_operator == "!=") {
				_operator_compared_result = _lval != _rval;
			}
			
			if (false == _operator_compared_result) {
				throw ({
					message: self.message ?? "assert_string_length_compare", 
					rval: self.rval,
					length: _lval,
				});
			}
		});
		
		return _callback;
		
	}
}

function assert_array_length_compare(_operator, _rval, _message=undefined) {
	if (ASSERTS_ENABLE) {
		
		if (false == array_contains(["==", ">=", "<=", "<", ">", "!="], _operator)) {
			throw ({
				message: "ASSERTS_BAD_CONTSUCTOR_ARGUMENTS",
			});
		}
		
		var _context = {
			rval: _rval,
			operator: _operator,
			message: _message,
		};
		var _callback = method(_context, function(_array) {
			var _operator = self.operator;
			var _rval = self.rval;
			var _lval = array_length(_array);
			var _operator_compared_result;
			
			if (_operator == "==") {
				_operator_compared_result = _lval == _rval;
			} else if (_operator == ">=") {
				_operator_compared_result = _lval >= _rval;
			} else if (_operator == "<=") {
				_operator_compared_result = _lval <= _rval;
			} else if (_operator == ">") {
				_operator_compared_result = _lval > _rval;
			} else if (_operator == "<") {
				_operator_compared_result = _lval < _rval;
			} else if (_operator == "!=") {
				_operator_compared_result = _lval != _rval;
			}
			
			if (false == _operator_compared_result) {
				throw ({
					message: self.message ?? "assert_array_size_compare", 
					rval: self.rval,
					length: _lval,
				});
			}
		});
		
		return _callback;
		
	}
}

function assert_number_compare(_operator, _rval, _message=undefined) {
	if (ASSERTS_ENABLE) {
		
		if (false == array_contains(["==", ">=", "<=", "<", ">", "!="], _operator)) {
			throw ({
				message: "ASSERTS_BAD_CONTSUCTOR_ARGUMENTS",
			});
		}
		
		var _context = {
			rval: _rval,
			operator: _operator,
			message: _message,
		};
		var _callback = method(_context, function(_lval) {
			var _operator = self.operator;
			var _rval = self.rval;
			var _operator_compared_result;
			
			if (_operator == "==") {
				_operator_compared_result = _lval == _rval;
			} else if (_operator == ">=") {
				_operator_compared_result = _lval >= _rval;
			} else if (_operator == "<=") {
				_operator_compared_result = _lval <= _rval;
			} else if (_operator == ">") {
				_operator_compared_result = _lval > _rval;
			} else if (_operator == "<") {
				_operator_compared_result = _lval < _rval;
			} else if (_operator == "!=") {
				_operator_compared_result = _lval != _rval;
			}
			
			if (false == _operator_compared_result) {
				throw ({
					message: self.message ?? "assert_number_compare", 
					rval: self.rval,
					lval: _lval,
				});
			}
		});
		
		return _callback;
		
	}
}
