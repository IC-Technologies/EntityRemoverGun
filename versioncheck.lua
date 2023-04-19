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

-- Returns the current version set in fxmanifest.lua
function GetCurrentVersion()
	return GetResourceMetadata(GetCurrentResourceName(), "version")
end 

-- Grabs the latest version number from the web GitHub
PerformHttpRequest("https://raw.githubusercontent.com/IC-Technologies/EntityRemoverGun/version.txt", function(error, updatedVersion, headers)
	-- Wait to reduce spam 
	Citizen.Wait(2500)

	-- Get the current resource version 
	local currentVersion = GetCurrentVersion()
	
	if (updatedVersion ~= nil) then 
		-- If the versions are different, print it out
		if (updatedVersion ~= currentVersion) then
			print('EntityRemoverGun is outdated, go to https://github.com/IC-Technologies/EntityRemoverGun/releases to get the latest version.')
			print("Current Version: " .. currentVersion)
			print("Latest Version: " .. updatedVersion)
		else
			print('EntityRemoverGun is up to date!')
			print("Current Version: " .. currentVersion)
		end
	else 
		-- In case the version can not be requested, print out an error message
		print('There was an error in the checks for the latest version, if the issue persists create a support post in the IC Technologies discord: https://discord.gg/ZEPcRUU')
	end 
end)