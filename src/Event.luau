export type Event = {
  _OnServerEvent: ((player: Player, ...any) -> nil)?,
  _OnClientEvent: ((...any) -> nil)?,
  _NetworkId: any?,

  OnServerEvent: (self: Event, callback: (player: Player, ...any) -> nil) -> ();
  OnClientEvent: (self: Event, callback: (...any) -> nil) -> ();
  FireServer: (self: Event, ...any) -> ();
  FireClient: (self: Event, player: Player, ...any) -> ();
  FireAllClientsExcept: (self: Event, ignorePlayer: Player, ...any) -> ();
  FireAllClients: (self: Event, ...any) -> ();
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService");

local Event = {};
Event.__index = Event;

local remoteEvent = nil;

function Event.getRemoteEvent()
  if not remoteEvent then
    remoteEvent = script.Parent:WaitForChild("RemoteEvent");
  end

  return remoteEvent;
end

function Event:OnServerEvent(callback: (player : Player, ...any) -> nil)
  if RunService:IsClient() then
    warn("[Nexus]: You can only call OnServerEvent on the server!");
    return;
  end
  self._OnServerEvent = callback;
end

function Event:OnClientEvent(callback : (...any) -> nil)
  if RunService:IsServer() then
    warn("[Nexus]: You can only call OnClientEvent on the client!");
    return;
  end
  self._OnClientEvent = callback;
end

function Event:FireServer(...)
  if RunService:IsServer() then
    warn("[Nexus]: You can only call FireServer on the client!");
    return;
  end
  local remote = Event.getRemoteEvent();
  remote:FireServer(self._NetworkId, ...)
end

function Event:FireClient(player : Player, ...)
  if RunService:IsClient() then
    warn("[Nexus]: You can only call FireClient on the server!");
    return;
  end
  local remote = Event.getRemoteEvent();
  remote:FireClient(player, self._NetworkId, ...)
end

function Event:FireAllClientsExcept(ignorePlayer : Player, ...)
  if RunService:IsClient() then
    warn("[Nexus]: You can only call FireAllClientsExcept on the server!");
    return;
  end

  for _, player in Players:GetPlayers() do
    if player ~= ignorePlayer then
      self:FireClient(player, ...);
    end
  end
end

function Event:FireAllClients(...)
  if RunService:IsClient() then
    warn("[Nexus]: You can only call FireAllClients on the server!");
    return;
  end

  local remote = Event.getRemoteEvent();
  remote:FireAllClients(self._NetworkId, ...)
end

function Event.new()
  local event = setmetatable({}, Event);
  
  event._OnServerEvent = nil;
  event._OnClientEvent = nil;
  event._NetworkId = nil;

  return event;
end

return Event;