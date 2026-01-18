
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

_test = test_uncaught_handler_2;

show_debug_message("");
show_debug_message(_test.name);
if (_test.is_finished) {
	show_debug_message("OK: finished");
} else {
	show_debug_message("FAIL: finished");
}

_test = test_uncaught_handler_3;

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

_test = test_later_dobule_resolve;

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

_test = test_later_dobule_reject;

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

_test = test_correct_chain;

show_debug_message("");
show_debug_message(_test.name);
if (_test.on_1_expected == _test.on_1_received) {
	show_debug_message("OK: 1 equals");
} else {
	show_debug_message("FAIL: 1 no equals");
}
if (_test.on_1_expected == _test.on_1_received_later) {
	show_debug_message("OK: 1 equals later");
} else {
	show_debug_message("FAIL: 1 no equals later");
}
if (_test.on_2_expected == _test.on_2_received) {
	show_debug_message("OK: 2 equals");
} else {
	show_debug_message("FAIL: 2 no equals");
}
if (_test.on_2_expected == _test.on_2_received_later) {
	show_debug_message("OK: 2 equals later");
} else {
	show_debug_message("FAIL: 2 no equals later");
}
if (_test.on_3_expected == _test.on_3_received) {
	show_debug_message("OK: 3 equals");
} else {
	show_debug_message("FAIL: 3 no equals");
}
if (_test.on_3_expected == _test.on_3_received_later) {
	show_debug_message("OK: 3 equals later");
} else {
	show_debug_message("FAIL: 3 no equals later");
}
if (_test.on_4_expected == _test.on_4_received) {
	show_debug_message("OK: 4 equals");
} else {
	show_debug_message("FAIL: 4 no equals");
}
if (_test.on_4_expected == _test.on_4_received_later) {
	show_debug_message("OK: 4 equals later");
} else {
	show_debug_message("FAIL: 4 no equals later");
}
if (_test.on_5_expected == _test.on_5_received) {
	show_debug_message("OK: 5 equals");
} else {
	show_debug_message("FAIL: 5 no equals");
}
if (_test.on_5_expected == _test.on_5_received_later) {
	show_debug_message("OK: 5 equals later");
} else {
	show_debug_message("FAIL: 5 no equals later");
}
if (_test.on_6_expected == _test.on_6_received) {
	show_debug_message("OK: 6 equals");
} else {
	show_debug_message("FAIL: 6 no equals");
}
if (_test.on_6_expected == _test.on_6_received_later) {
	show_debug_message("OK: 6 equals later");
} else {
	show_debug_message("FAIL: 6 no equals later");
}
if (_test.on_7_expected == _test.on_7_received) {
	show_debug_message("OK: 7 equals");
} else {
	show_debug_message("FAIL: 7 no equals");
}
if (_test.on_7_expected == _test.on_7_received_later) {
	show_debug_message("OK: 7 equals later");
} else {
	show_debug_message("FAIL: 7 no equals later");
}
if (_test.on_8_expected == _test.on_8_received) {
	show_debug_message("OK: 8 equals");
} else {
	show_debug_message("FAIL: 8 no equals");
}
if (_test.on_8_expected == _test.on_8_received_later) {
	show_debug_message("OK: 8 equals later");
} else {
	show_debug_message("FAIL: 8 no equals later");
}
if (_test.on_9_expected == _test.on_9_received) {
	show_debug_message("OK: 9 equals");
} else {
	show_debug_message("FAIL: 9 no equals");
}
if (_test.on_9_expected == _test.on_9_received_later) {
	show_debug_message("OK: 9 equals later");
} else {
	show_debug_message("FAIL: 9 no equals later");
}
if (_test.on_10_expected == _test.on_10_received) {
	show_debug_message("OK: 10 equals");
} else {
	show_debug_message("FAIL: 10 no equals");
}
if (_test.on_10_expected == _test.on_10_received_later) {
	show_debug_message("OK: 10 equals later");
} else {
	show_debug_message("FAIL: 10 no equals later");
}
if (_test.on_11_expected == _test.on_11_received) {
	show_debug_message("OK: 11 equals");
} else {
	show_debug_message("FAIL: 11 no equals");
}
if (_test.on_11_expected == _test.on_11_received_later) {
	show_debug_message("OK: 11 equals later");
} else {
	show_debug_message("FAIL: 11 no equals later");
}
