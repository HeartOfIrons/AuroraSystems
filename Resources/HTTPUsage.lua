
--[[
  You can find out how your HTTP Services are being used here. This contains the fully up-to-date code that runs and uses HTTP.
--]]

local function RunHTTP(Player,Filer)
	Shortcuts.Util.ErrorCall("RunHTTP() ran for "..Player.Name.." with file type of "..tostring(Filer)..". Please make sure this isn't maliciously being used.","3","warn")
	if Services.HttpService.HttpEnabled then
		local response = Services.HttpService:GetAsync(Shortcuts.Data.System.ExternalData) -- 🔴 Redirects to the ExternalData JSON File which contains the newest version.
		local success, jsonData = pcall(function() return Services.HttpService:JSONDecode(response) end)
		if success then
			local latestVersion = jsonData.Version
			if Shortcuts.Data.System.LatestVersion == latestVersion then
				Shortcuts.Events.StC_Data:FireClient(Player,"Version","UP TO DATE")
			else
				Shortcuts.Util.ErrorCall("Outdated version of Aurora. UI Version: "..Shortcuts.Data.System.LatestVersion,"3","warn")
				Shortcuts.Events.StC_Data:FireClient(Player,"Version","OUTDATED")
			end
		else
			Shortcuts.Util.ErrorCall("Error receiving the UI Version. Please report this bug to the Aurora Creator. Error occured at "..os.time(),"4","warn")
			Shortcuts.Events.StC_Data:FireClient(Player,"Version","UNKNOWN")
		end
	else
		Shortcuts.Util.ErrorCall("HTTP Services are disabled. Please enable them for Aurora to work.","4","warn")
	end
end
