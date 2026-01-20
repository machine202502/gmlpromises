
#macro GAME_PRODUCTION false

function env(_key) {
	static _env = GAME_PRODUCTION ? __env_prod() : __env_dev();
	
	var _value = struct_get(_env, _key);
	return _value;
	
}

function __env_prod() {
	static _env = {
		manager_url: "http://localhost:4023/",
	};
	
	return _env;
}

function __env_dev() {
	static _env = {
		manager_url: "http://localhost:4023/",
	};
	
	return _env;
}
