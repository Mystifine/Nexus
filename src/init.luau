local RunService = game:GetService("RunService");

local Event = require(script.Event);
local Async = require(script.Async);
local UnreliableEvent = require(script.UnreliableEvent);

local Nexus = {};
Nexus._RemoteEvent = nil;
Nexus._RemoteFunction = nil;
Nexus._UnreliableRemoteEvent = nil;
Nexus._Connections = {
  Events = {},
  Asyncs = {},
  UnreliableEvents = {},
};

function Nexus.Event()
  local event = Event.new();
  
  return event;
end

function Nexus.Define(remotes : {[string] : {[string] : any}})
  for _, channels in remotes do
    for _, channelItem in channels do
      if getmetatable(channelItem) == Event then
        table.insert(Nexus._Connections.Events, channelItem);
      elseif getmetatable(channelItem) == Async then
        table.insert(Nexus._Connections.Asyncs, channelItem);
      elseif getmetatable(channelItem) == UnreliableEvent then 
        table.insert(Nexus._Connections.UnreliableEvents, channelItem);
      end
    end
  end

  return remotes;
end

function Nexus._OnServerEvent(player : Player, )
  
end

function Nexus.Start()
  
  local isServer = RunService:IsServer();

  if isServer then
    Nexus._RemoteEvent = Instance.new("RemoteEvent");
    Nexus._RemoteEvent.Parent = script;

    Nexus._UnreliableRemoteEvent = Instance.new("UnreliableRemoteEvent");
    Nexus._UnreliableRemoteEvent.Parent = script;

    Nexus._RemoteFunction = Instance.new("RemoteFunction");
    Nexus._RemoteFunction.Parent = script;
    print("[Nexus]: Remotes have been loaded!");
  else
    print("[Nexus]: Loading remotes... make sure you called .Start() on the server");
    Nexus._RemoteEvent = script:WaitForChild("RemoteEvent");
    Nexus._RemoteFunction = script:WaitForChild("RemoteFunction");
    Nexus._UnreliableRemoteEvent = script:WaitForChild("UnreliableRemoteEvent");
  end

end


return Nexus;