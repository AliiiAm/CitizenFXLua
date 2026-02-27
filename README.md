# <img src="https://cdnjs.cloudflare.com/ajax/libs/emojione/2.2.6/assets/png/1f40c.png" width="32" height="32"> CitizenFX Lua Emulator For MTA:SA 

CitizenFXLua is a Lua CitizenFX / FiveM emulator for MTA:SA.
This project provides a compatibility layer that allows CitizenFX Lua scripts to run inside Multi Theft Auto: San Andreas (MTA:SA).
The goal is to recreate the CitizenFX Lua runtime and API so FiveM scripts can be tested or ported more easily to MTA.

## Overview
CitizenFXLua emulates core parts of the CitizenFX Lua runtime:
- Citizen threads
- Wait system (only for threads rn)
- TriggerEvent system with callback ( Serverside & Clientside )

## Features
### Citizen Runtime
```lua
a = 0
Citizen.CreateThread(function()
    while true do
        a = a + 1
        print(a)
        Wait(0) -- This is mandatory and must be.
    end
end)
```
### Event System
```lua
RegisterNetEvent("test",function(cb,data)
 cb("OK "..data)
end)
```

```lua
TriggerNetEvent("test",function(r)
		print(r,"FROM SERVER")
end,"Hello")
```

## TODO
- [x] Thread & Runtime
- [x] Event system
- [x] Exports system
- [ ] NuiManager
  - [ ] Lua & JS Bridge
- [ ] Promise & Async System
- [ ] Full Citizen API

## Contributing
Pull requests are welcome.
Guidelines:
- Keep compatibility with MTA
- Follow CitizenFX behavior

## License
MIT License
