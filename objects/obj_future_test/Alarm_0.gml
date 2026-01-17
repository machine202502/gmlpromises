
var _test;

_test = test_resolve;

show_debug_message("");
show_debug_message(_test.name);
if (_test.is_finished) {
	show_debug_message("OK: finished");
} else {
	show_debug_message("FAIL: finished");
}
if (_test.expected == _test.received) {
	show_debug_message("OK: equals");
} else {
	show_debug_message("FAIL: not equals");
}

_test = test_reject;

show_debug_message("");
show_debug_message(_test.name);
if (_test.is_finished) {
	show_debug_message("OK: finished");
} else {
	show_debug_message("FAIL: finished");
}
if (_test.expected == _test.received) {
	show_debug_message("OK: equals");
} else {
	show_debug_message("FAIL: not equals");
}

_test = test_later_resolve;

show_debug_message("");
show_debug_message(_test.name);
if (_test.is_finished) {
	show_debug_message("OK: finished");
} else {
	show_debug_message("FAIL: finished");
}
if (_test.expected == _test.received) {
	show_debug_message("OK: equals");
} else {
	show_debug_message("FAIL: not equals");
}

_test = test_later_reject;

show_debug_message("");
show_debug_message(_test.name);
if (_test.is_finished) {
	show_debug_message("OK: finished");
} else {
	show_debug_message("FAIL: finished");
}
if (_test.expected == _test.received) {
	show_debug_message("OK: equals");
} else {
	show_debug_message("FAIL: not equals");
}

_test = test_uncaught_handler;

show_debug_message("");
show_debug_message(_test.name);
if (_test.is_finished) {
	show_debug_message("OK: finished");
} else {
	show_debug_message("FAIL: finished");
}

_test = test_reject_after_throw;

show_debug_message("");
show_debug_message(_test.name);
if (_test.is_finished) {
	show_debug_message("OK: finished");
} else {
	show_debug_message("FAIL: finished");
}
if (_test.expected == _test.received) {
	show_debug_message("OK: equals");
} else {
	show_debug_message("FAIL: not equals");
}

_test = test_finally_after_resolve;

show_debug_message("");
show_debug_message(_test.name);
if (_test.expected_a == _test.received_a) {
	show_debug_message("OK: equals for A group");
} else {
	show_debug_message("FAIL: not equals for A group");
}
if (_test.expected_b == _test.received_b) {
	show_debug_message("OK: equals for B group");
} else {
	show_debug_message("FAIL: not equals for B group");
}

_test = test_finally_after_reject;

show_debug_message("");
show_debug_message(_test.name);
if (_test.expected_a == _test.received_a) {
	show_debug_message("OK: equals for A group");
} else {
	show_debug_message("FAIL: not equals for A group");
}
if (_test.expected_b == _test.received_b) {
	show_debug_message("OK: equals for B group");
} else {
	show_debug_message("FAIL: not equals for B group");
}