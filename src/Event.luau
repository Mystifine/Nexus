local Event = {};
Event._index = Event;

function Event:OnServerEvent()
  
end

function Event:OnClientEvent()
  
end

function Event:FireServer()
  
end

function Event:FireClient()
  
end

function Event.new()
  local event = setmetatable({}, Event);
  
  event.OnServerEvent = nil;
  event.OnClientEvent = nil;

  return event;
end

return Event;