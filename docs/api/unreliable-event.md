# UnreliableEvent

The `UnreliableEvent` object uses Roblox `UnreliableRemoteEvent` to send fast, best-effort messages.

## Methods

### `UnreliableEvent:OnServerEvent(callback)`

Registers a callback on the server that runs when a client fires the unreliable event.

- `callback(player, ...)` — receives the player and any arguments.

### `UnreliableEvent:OnClientEvent(callback)`

Registers a callback on the client that runs when the server fires the unreliable event.

- `callback(...)` — receives the forwarded arguments.

### `UnreliableEvent:FireServer(...)`

Fires the event from the client to the server.

### `UnreliableEvent:FireClient(player, ...)`

Fires the event from the server to a specific client.

### `UnreliableEvent:FireAllClientsExcept(ignorePlayer, ...)`

Fires the event to every client except the ignored player.

### `UnreliableEvent:FireAllClients(...)`

Fires the event to every connected client.

## Usage

Use `UnreliableEvent` for high-frequency updates, telemetry, or other messages where occasional packet loss is acceptable.
