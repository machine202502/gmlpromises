
var _future = async_timeout(1500, "hello");
_future.once(function(_is_resolved, _result) {
	show_debug_message("");
	show_debug_message("timeout");
	show_debug_message([_is_resolved, _result]);
});

self.future = _future;

async_timeout(2500, "world").on_then(function(_resolved) {
	show_debug_message("timeout 2");
	show_debug_message(_resolved);
		
	self.future.on_then(function(_resolved) {
		show_debug_message("timeout repeat");
		show_debug_message(_resolved);
	});
});

async_timeout(0).on_then(function(_resolved) {
	show_debug_message("");
	show_debug_message("timeout 3");
	show_debug_message(_resolved);
});
async_timeout(1500).on_catch(function(_rejected) {
	show_debug_message("");
	show_debug_message("timeout 4");
	show_debug_message(_rejected);
});


get_http_simpled("http://localhost:4023/ping").once(function(_is_resolved, _result) {
	show_debug_message({
		resolved: _is_resolved, 
		result: _result 
	});
});

future_race([
	async_timeout(1500, 1).on_then(functor_id),
	async_timeout(5500, 2).on_then(functor_throw),
]).once(function(_is_resolved, _result) {
	show_debug_message({
		resolved: _is_resolved, 
		result: _result 
	});
});


var _param = future_with_resolvers();

_param.future.once(function (_a, _b) {
	show_debug_message([_a, _b]);
});

_param.resolve(11);
_param.resolve(22);



