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

function CheckPermission(player)
    if (Config.aceperm == nil or Config.aceperm == "") or IsPlayerAceAllowed(player, Config.aceperm) then
        return true
    else
        return false
    end
end

if GetNumPlayerIndices() ~= 0 then
    for _, id in ipairs(GetPlayers()) do
        if CheckPermission(id) then
            TriggerClientEvent("EntityRemover:GivePermission", id, true)
        end
    end
end

RegisterNetEvent("EntityRemover:CheckPermission")
AddEventHandler("EntityRemover:CheckPermission", function()
    local src = source
    if CheckPermission(src) then
        TriggerClientEvent("EntityRemover:GivePermission", src, true)
    end
end)

RegisterNetEvent("EntityRemover:DeleteEntity")
AddEventHandler("EntityRemover:DeleteEntity", function(entID)
    local ent = NetworkGetEntityFromNetworkId(entID)

    if DoesEntityExist(ent) then
        DeleteEntity(ent)

        Citizen.Wait(1000)

        ent = NetworkGetEntityFromNetworkId(entID)

        if DoesEntityExist(ent) then
            local owner = NetworkGetEntityOwner(ent)
            TriggerClientEvent("EntityRemover:DeleteFromClient", owner, entID)

            Citizen.Wait(1000)

            ent = NetworkGetEntityFromNetworkId(entID)

            if DoesEntityExist(ent) then
                print("The entity could not be deleted. Please contact ICTechnologies on their discord. Error Code: 100")
            end
        end
    end
end)