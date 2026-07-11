# Nexus API

The root Nexus module is responsible for defining named remote channels and starting the underlying Roblox remote instances.

## Functions

### `Nexus.Event()`

Creates a new reliable event channel.

Returns:

- `Event` — a new event instance.

### `Nexus.Async()`

Creates a new request-response async channel.

Returns:

- `Async` — a new async instance.

### `Nexus.UnreliableEvent()`

Creates a new unreliable event channel.

Returns:

- `UnreliableEvent` — a new unreliable event instance.

### `Nexus.Define(remotes)`

Registers a collection of named remote channels to be used by the module.

Parameters:

- `remotes` — a table shaped like `{ namespace = { channelName = Nexus.Event() | Nexus.Async() | Nexus.UnreliableEvent() } }`.

Returns:

- The same `remotes` table with network identifiers assigned.

### `Nexus.Start()`

Initializes the underlying `RemoteEvent`, `RemoteFunction`, and `UnreliableRemoteEvent` instances on the server, and attaches client-side handlers on the client.

Call `Nexus.Start()` once before using defined remote channels in your game.

## Notes

- `Define` must be called before the first network request.
- `Start` must be called on the server before client code attempts to use the remote channels.
