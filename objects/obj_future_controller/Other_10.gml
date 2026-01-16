
if (is_callable(self.handler_init)) {
	self.handler_init(self.handler_resolve, self.handler_reject);
	return;
}

throw ({
	message: "dont't callbable handler init function",
});
