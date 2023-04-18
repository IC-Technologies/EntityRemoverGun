    --[[
    Copyright (C) 2023 ICTechnologies

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    ]]

local hasPerm = false
local isdeleteing = false

RegisterNetEvent("EntityRemover:GivePermission")
AddEventHandler("EntityRemover:GivePermission", function(bool)
    hasPerm = bool
end)

RegisterNetEvent("EntityRemover:DeleteFromClient", function(entID)
    local ent = NetworkGetEntityFromNetworkId(entID)
    if DoesEntityExist(ent) then
        DeleteEntity(ent)
    end
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("EntityRemover:CheckPermission")
end)

function Draw2DText(x, y, text, scale, center)
    -- Draw text on screen
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    if center then 
    	SetTextJustification(0)
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

Citizen.CreateThread(function()
    local timeout = 30

    TriggerServerEvent("EntityRemover:CheckPermission")

    while not hasPerm and timeout ~= 0 do
        Wait(1000)
        timeout = timeout - 1
    end

    if hasPerm then
        RegisterCommand(Config.command, function(source, args)
            isdeleteing = not isdeleteing
           
            if not Config.Display.enable then
                if isdeleteing then
                    TriggerEvent("chatMessage", "Now Deleting Entities...  Aim at an Entity and Press ^1E ^0to delete.")
                else
                    TriggerEvent("chatMessage", "No Longer Dleteing Entities") 
                end

                Wait(60000)
    
                if isdeleteing then
                    TriggerEvent("chatMessage", "You Are Still Deleting Entities... Aim at an Entity and Press ^1E ^0to delete.")
                end
            end
        end)

        TriggerEvent("chat:addSuggestion", "/" .. Config.command, Config.helptext)

        while true do
            Wait(1)
            if isdeleteing then
    
                local found, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
    
                if found and IsControlPressed(2, Config.button) then
                    NetworkRegisterEntityAsNetworked(entity)
    
                    local entID = NetworkGetNetworkIdFromEntity(entity)
                    TriggerServerEvent("EntityRemover:DeleteEntity", entID)
                end
            end
        end 
    end
end)

if Config.Display.enable then
    Citizen.CreateThread(function()
        while true do
            Wait(0)
            if isdeleteing then
                Draw2DText(Config.Display.x, Config.Display.y, Config.Display.text, Config.Display.scale, Config.Display.center)
            end
        end 
    end)
end






