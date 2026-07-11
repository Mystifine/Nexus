# Nexus

Nexus is a lightweight Roblox networking module that simplifies remote communication between the server and clients.

!!! warning "AI-Assisted Documentation"
    Documentation is AI-Assisted and may contain inaccuracies. Please report any issues or suggestions on the [GitHub Issues Page](https://github.com/Mystifine/Nexus/issues).

It ships with three main abstractions:

- **Event** — reliable fire-and-forget remote events.
- **Async** — request-response remote functions.
- **UnreliableEvent** — fire-and-forget events for non-critical real-time updates.

## What is Nexus for?

Nexus is designed for Roblox developers who want a clean, organized pattern for declaring and using remote channels without manually managing `RemoteEvent`, `RemoteFunction`, and `UnreliableRemoteEvent` instances.

## Documentation

- [Getting Started](getting-started.md)
- [API Reference](api/nexus.md)
- [Development](development.md)
