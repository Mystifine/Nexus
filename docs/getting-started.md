# Getting Started

## Requirements

- Roblox Studio
- Rojo (for local development and project syncing)
- A Roblox place or game to load your Nexus module into

## Installing Nexus

Nexus is packaged with Wally and can be included as a dependency in your Roblox project.

If you use Wally, add Nexus to your dependency list in `wally.toml` and install it with:

```bash
wally install
```

Alternatively, copy the `src` folder into your project and require `src/init`.

## Basic Workflow

1. Create your networking definition using `Nexus.Define()`.
2. Call `Nexus.Start()` on the server to initialize the remote instances.
3. Register event handlers, then use the `Fire` and `Invoke` methods from client and server code.

## Example

```lua
local Nexus = require(path.to.Nexus)

local remotes = Nexus.Define({
    chat = {
        playerMessage = Nexus.Event(),
        requestStatus = Nexus.Async(),
        heartbeat = Nexus.UnreliableEvent(),
    }
})

-- Server setup
if game:GetService("RunService"):IsServer() then
    Nexus.Start()

    remotes.chat.playerMessage:OnServerEvent(function(player, message)
        print(player.Name .. " says: " .. message)
    end)

    remotes.chat.requestStatus:OnServerInvoke(function(player)
        return {
            time = os.time(),
            players = #game:GetService("Players"):GetPlayers(),
        }
    end)
end

-- Client usage
if game:GetService("RunService"):IsClient() then
    remotes.chat.playerMessage:FireServer("Hello from the client!")

    local status = remotes.chat.requestStatus:InvokeServer()
    print(status.time)
end
```

## When to use each type

- Use `Event` for reliable broadcast-style communication.
- Use `Async` when you need a response from the remote side.
- Use `UnreliableEvent` for fast updates where dropped packets are acceptable.
