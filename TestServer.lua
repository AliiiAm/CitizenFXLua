-- Test Server Side

a = 0
CreateThread(function()
    while true do
        a = a + 1
        print(a)
        Wait(0) -- This is mandatory and must be.
    end
end)

RegisterNetEvent("test",function(cb,data)
 cb("OK "..data)
end)

addCommandHandler("testcallside",function()
    TriggerNetEvent("test",function(r)
		print(r,"FROM SERVER")
	end,"Hello")
end)

addCommandHandler("testcallsv",function(ply)
    TriggerNetSideEvent("testcl",ply,function(r)
		print(r)
	end,"Hello")
end)