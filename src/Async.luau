export type Async = {
  _OnServerInvoke: ((player: Player, ...any) -> any)?,
  _OnClientInvoke: ((...any) -> any)?,
  _NetworkId: any?,

  OnServerInvoke: (self: Async, callback: (player: Player, ...any) -> any) -> ();
  OnClientInvoke: (self: Async, callback: (...any) -> any) -> ();
  InvokeServer: (self: Async, ...any) -> any;
  InvokeClient: (self: Async, player: Player, ...any) -> any;
  new: () -> Async;
}

local RunService = game:GetService("RunService");

local Async = {};
Async.__index = Async;

local remoteFunction = nil;

function Async.getRemoteFunction()
  if not remoteFunction then
    remoteFunction = script.Parent:WaitForChild("RemoteFunction");
  end

  return remoteFunction;
end

function Async:OnServerInvoke(callback: (player : Player, ...any) -> any)
  if RunService:IsClient() then
    warn("[Nexus]: You can only call OnServerInvoke on the server!");
    return;
  end
  self._OnServerInvoke = callback;
end

function Async:OnClientInvoke(callback : (...any) -> any)
  if RunService:IsServer() then
    warn("[Nexus]: You can only call OnClientInvoke on the client!");
    return;
  end
  self._OnClientInvoke = callback;
end

function Async:InvokeServer(...)
  if RunService:IsServer() then
    warn("[Nexus]: You can only call InvokeServer on the client!");
    return;
  end
  local remote = Async.getRemoteFunction();
  return remote:InvokeServer(self._NetworkId, ...)
end

function Async:InvokeClient(player : Player, ...)
  if RunService:IsClient() then
    warn("[Nexus]: You can only call InvokeClient on the server!");
    return;
  end
  local remote = Async.getRemoteFunction();
  return remote:InvokeClient(player, self._NetworkId, ...)
end

function Async.new()
  local async = setmetatable({}, Async);
  
  async._OnServerInvoke = nil;
  async._OnClientInvoke = nil;
  async._NetworkId = nil;

  return async;
end

return Async;