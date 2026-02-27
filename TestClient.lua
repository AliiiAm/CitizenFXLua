-- Test Client Side

addCommandHandler("testcall",function()
	TriggerNetSideEvent("test",localPlayer,function(r)
		print(r)
	end,"Hello")
end)

RegisterNetEvent("testcl",function(cb,data)
	cb("CLIENT "..data)
end)