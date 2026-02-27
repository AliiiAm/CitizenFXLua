-- CitizenFX Lua Emulator For MTA:SA
-- By -Alii

local Logger = false

local IS_CLIENT = (localPlayer ~= nil)
local Network = {}

Network.Events = {}
Network.Callbacks = {}
Network.CallbackID = 0


Citizen = {} -- I know...

function CreateThread(func)
    local co = coroutine.create(func)
    local function resumeThread()
        if coroutine.status(co) ~= "dead" then
            local ok, wait = coroutine.resume(co)
            if not ok then
                outputDebugString("Thread Error: "..tostring(wait))
                return
            end
            setTimer(resumeThread, wait or 0, 1)
        end
    end
    resumeThread()
end

function Wait(ms)
    coroutine.yield(ms)
end


function RegisterNetEvent(name, func)
    Network.Events[name] = func
    if Logger then
        outputDebugString("Registered: "..name)
    end
end

function TriggerNetEvent(name, cb, ...)

    local ev = Network.Events[name]

    if not ev then
        if Logger then
            outputDebugString("Event missing: "..name)
        end
        return
    end
    ev(cb,...)
end

local function CreateCallback(cb)
    if type(cb) ~= "function" then
        return 0
    end
    Network.CallbackID = Network.CallbackID + 1
    local id = Network.CallbackID
    Network.Callbacks[id] = cb
    return id
end

local function RunCallback(id,...)
    local cb = Network.Callbacks[id]
    if cb then
        cb(...)
        Network.Callbacks[id] = nil
    end
end

function TriggerNetSideEvent(name, elem, cb, ...)

    local id = CreateCallback(cb)

    if IS_CLIENT then
        triggerServerEvent("CitizenFX:Event",elem or localPlayer,name,id,...)
    else
        triggerClientEvent(elem or root,"CitizenFX:Event",resourceRoot,name,id,...)
    end
end

addEvent("CitizenFX:Event",true)
addEventHandler("CitizenFX:Event",root,function(name,id,...)
    local function reply(...)
        if id == 0 then return end

        if IS_CLIENT then
            triggerServerEvent("CitizenFX:Callback",localPlayer,id,...)
        else
            triggerClientEvent(client,"CitizenFX:Callback",resourceRoot,id,...)
        end
    end
    TriggerNetEvent(name,reply,...)
end)

addEvent("CitizenFX:Callback",true)
addEventHandler("CitizenFX:Callback",root,function(id,...)
    RunCallback(id,...)
end)

-- Yes, I know it's a weird thing, but...
Citizen.CreateThread = CreateThread
Citizen.Wait = Wait
Citizen.RegisterNetEvent = RegisterNetEvent
Citizen.TriggerNetEvent = TriggerNetEvent

Citizen.TriggerNetSideEvent = TriggerNetSideEvent

-- For Exports
function GetCitizen()
    return Citizen
end
