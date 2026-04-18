# JavaScript (Node.js) vs GML — Promises API

## 📌 Core Differences

| JavaScript (Node.js / Browser)            | GML (GameMaker Language)              |
|------------------------------------------|--------------------------------------|
| `new Promise(handler)`                   | `promise(handler)`                   |
| `Promise.resolve(value)`                 | `promise_resolve(value)`             |
| `Promise.reject(value)`                  | `promise_reject(value)`              |
| `.then(handler)`                         | `.on_then(handler)`                  |
| `.catch(handler)`                        | `.on_catch(handler)`                 |
| `.finally(handler)`                      | `.on_finally(handler)`               |
| `Promise.all([...])`                     | `promise_all([...])`                 |
| `Promise.any([...])`                     | `promise_any([...])`                 |
| `Promise.race([...])`                    | `promise_race([...])`                |
| `Promise.allSettled([...])`              | `promise_all_settled([...])`         |
| `process.on('unhandledRejection', fn)`   | `promise_set_uncaught_handler(fn)`   |
| `Promise.withResolvers()`                | `promise_with_resolvers()`           |

---

## ⚙️ Additional API

| Name                 | Description                                  |
|----------------------|----------------------------------------------|
| `async_http_request` | Asynchronous HTTP request                    |
| `async_timeout`      | Timer based on seconds                       |
| `async_frameout`     | Timer based on frames                        |
| `.on(...)`           | Unified handler (`then + catch`)             |

### Unified handler example

```gml
promise.on(function(is_resolved, result) {
    if (is_resolved) {
        // success
    } else {
        // error
    }
});
