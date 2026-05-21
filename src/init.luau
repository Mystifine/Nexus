local RunService = game:GetService("RunService");

local Event = require(script.Event);
local Async = require(script.Async);
local UnreliableEvent = require(script.UnreliableEvent);

local Nexus = {};
Nexus._RemoteEvent = nil;
Nexus._RemoteFunction = nil;
Nexus._UnreliableRemoteEvent = nil;
Nexus._RegisteredNetworks = {};

function Nexus.Event()
  return Event.new();
end

function Nexus.Async()
  return Async.new();
end

function Nexus.UnreliableEvent()
  return UnreliableEvent.new();
end

function Nexus.Define(remotes : {[string] : {[string] : Event.Event | Async.Async | UnreliableEvent.UnreliableEvent}})
  for namespace, channels in remotes do
    for channelName, channelItem in channels do
      local networkId = string.format("%s/%s", namespace, channelName);
      channelItem._NetworkId = networkId;
      Nexus._RegisteredNetworks[networkId] = channelItem;
    end
  end

  return remotes;
end

function Nexus._HandleServerNetworkRequest(player : Player, networkId : string, ...)
  local channelItem = Nexus._RegisteredNetworks[networkId];
  if not Nexus._RegisteredNetworks[networkId] then
    warn(string.format("[Nexus]: Received a server signal for network '%s'. Network is not registered (did you forget to call Define() and Start()?)", networkId));
    return;
  end

  if getmetatable(channelItem) == Event or getmetatable(channelItem) == UnreliableEvent then
    if not channelItem._OnServerEvent then
      warn(string.format("[Nexus]: OnServerEvent not set up for the network '%s'", networkId));
      return;
    else
      channelItem._OnServerEvent(player, ...);
    end
  elseif getmetatable(channelItem) == Async then
    if not channelItem._OnServerInvoke then
      warn(string.format("[Nexus]: OnServerInvoke not set up for the network '%s'", networkId));
      return;
    else
      return channelItem._OnServerInvoke(player, ...);
    end
  end
  return nil;
end

function Nexus._HandleClientNetworkRequest(networkId : string, ...)
  local channelItem = Nexus._RegisteredNetworks[networkId];
  if not Nexus._RegisteredNetworks[networkId] then
    warn(string.format("[Nexus]: Received a client signal for network '%s'. Network is not registered (did you forget to call Define() and Start()?)", networkId));
    return;
  end

  if getmetatable(channelItem) == Event or getmetatable(channelItem) == UnreliableEvent then
    if not channelItem._OnClientEvent then
      warn(string.format("[Nexus]: OnClientEvent not set up for the network '%s'", networkId));
      return;
    else
      channelItem._OnClientEvent(...);
    end
  elseif getmetatable(channelItem) == Async then
    if not channelItem._OnClientInvoke then
      warn(string.format("[Nexus]: OnClientInvoke not set up for the network '%s'", networkId));
      return;
    else
      return channelItem._OnClientInvoke(...);
    end
  end
  return nil;
end

function Nexus.Start()
  -- Need to initially set things up
  local isServer = RunService:IsServer();
  if isServer then
    Nexus._RemoteEvent = Instance.new("RemoteEvent");
    Nexus._RemoteEvent.Parent = script;
    Nexus._RemoteEvent.OnServerEvent:Connect(Nexus._HandleServerNetworkRequest);

    Nexus._UnreliableRemoteEvent = Instance.new("UnreliableRemoteEvent");
    Nexus._UnreliableRemoteEvent.Parent = script;
    Nexus._UnreliableRemoteEvent.OnServerEvent:Connect(Nexus._HandleServerNetworkRequest);

    Nexus._RemoteFunction = Instance.new("RemoteFunction");
    Nexus._RemoteFunction.Parent = script;
    Nexus._RemoteFunction.OnServerInvoke = Nexus._HandleServerNetworkRequest;
    print("[Nexus]: Remotes have been loaded!");
  else
    print("[Nexus]: Loading remotes... make sure you called .Start() on the server");
    Nexus._RemoteEvent = script:WaitForChild("RemoteEvent");
    Nexus._RemoteFunction = script:WaitForChild("RemoteFunction");
    Nexus._UnreliableRemoteEvent = script:WaitForChild("UnreliableRemoteEvent");

    Nexus._RemoteEvent.OnClientEvent:Connect(Nexus._HandleClientNetworkRequest);
    Nexus._RemoteFunction.OnClientInvoke = Nexus._HandleClientNetworkRequest;
    Nexus._UnreliableRemoteEvent.OnClientEvent:Connect(Nexus._HandleClientNetworkRequest);
  end
end

return Nexus;