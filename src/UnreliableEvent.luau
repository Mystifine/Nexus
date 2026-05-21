export type UnreliableEvent = {
	OnServerEvent: (self: UnreliableEvent, callback: (player: Player, ...any) -> nil) -> nil,
	OnClientEvent: (self: UnreliableEvent, callback: (...any) -> nil) -> nil,
	FireServer: (self: UnreliableEvent, ...any) -> nil,
	FireClient: (self: UnreliableEvent, player: Player, ...any) -> nil,
	FireAllClientsExcept: (self: UnreliableEvent, ignorePlayer: Player, ...any) -> nil,
	FireAllClients: (self: UnreliableEvent, ...any) -> nil,
	_OnServerEvent: ((player: Player, ...any) -> nil)?,
	_OnClientEvent: ((...any) -> nil)?,
	_NetworkId: string?,
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService");

local UnreliableEvent = {};
UnreliableEvent.__index = UnreliableEvent;

local unreliableRemoteEvent = nil;

function UnreliableEvent.getUnreliableRemoteEvent()
  if not unreliableRemoteEvent then
    unreliableRemoteEvent = script.Parent:WaitForChild("UnreliableRemoteEvent");
  end

  return unreliableRemoteEvent;
end

function UnreliableEvent:OnServerEvent(callback: (player : Player, ...any) -> nil)
  if RunService:IsClient() then
    warn("[Nexus]: You can only call OnServerEvent on the server!");
    return;
  end
  self._OnServerEvent = callback;
end

function UnreliableEvent:OnClientEvent(callback : (...any) -> nil)
  if RunService:IsServer() then
    warn("[Nexus]: You can only call OnClientEvent on the client!");
    return;
  end
  self._OnClientEvent = callback;
end

function UnreliableEvent:FireServer(...)
  if RunService:IsServer() then
    warn("[Nexus]: You can only call FireServer on the client!");
    return;
  end
  local remote = UnreliableEvent.getUnreliableRemoteEvent();
  remote:FireServer(self._NetworkId, ...)
end

function UnreliableEvent:FireClient(player : Player, ...)
  if RunService:IsClient() then
    warn("[Nexus]: You can only call FireClient on the server!");
    return;
  end
  local remote = UnreliableEvent.getUnreliableRemoteEvent();
  remote:FireClient(player, self._NetworkId, ...)
end

function UnreliableEvent:FireAllClientsExcept(ignorePlayer : Player, ...)
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

function UnreliableEvent:FireAllClients(...)
  if RunService:IsClient() then
    warn("[Nexus]: You can only call FireAllClients on the server!");
    return;
  end

  local remote = UnreliableEvent.getUnreliableRemoteEvent();
  remote:FireAllClients(self._NetworkId, ...)
end

function UnreliableEvent.new()
  local unreliableEvent = setmetatable({}, UnreliableEvent);
  
  unreliableEvent._OnServerEvent = nil;
  unreliableEvent._OnClientEvent = nil;
  unreliableEvent._NetworkId = nil;

  return unreliableEvent;
end

return UnreliableEvent;