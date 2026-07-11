# Async

`Async` provides request-response behavior using Roblox `RemoteFunction` semantics.

## Methods

### `Async:OnServerInvoke(callback)`

Registers a callback on the server for client invocations.

- `callback(player, ...)` — receives the calling player and any arguments.

### `Async:OnClientInvoke(callback)`

Registers a callback on the client for server invocations.

- `callback(...)` — receives any forwarded arguments.

### `Async:InvokeServer(...)`

Invokes the server from the client and returns the server response.

### `Async:InvokeClient(player, ...)`

Invokes a specific client from the server and returns the client response.

## Usage

Use `Async` when the remote side must answer with a value before continuing.
