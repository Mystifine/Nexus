# Event

The `Event` object provides a reliable remote event channel for server and client communication.

## Methods

### `Event:OnServerEvent(callback)`

Registers a callback on the server that runs when a client fires the event.

- `callback(player, ...)` — receives the player who fired the event and the forwarded arguments.

### `Event:OnClientEvent(callback)`

Registers a callback on the client that runs when the server fires the event.

- `callback(...)` — receives the forwarded arguments.

### `Event:FireServer(...)`

Fires the event from the client to the server.

### `Event:FireClient(player, ...)`

Fires the event from the server to a single client.

### `Event:FireAllClientsExcept(ignorePlayer, ...)`

Fires the event to every client except the ignored player.

### `Event:FireAllClients(...)`

Fires the event to every connected client.

## Usage

Use `Event` for reliable messages that must arrive in order and should not be dropped.
