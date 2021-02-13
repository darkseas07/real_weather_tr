local weathers = {
	["AÇIK"] = {
		type = "CLEAR",
		rain = -1
	},
	["PARÇALI BULUTLU"] = {
		type = "CLOUDS",
		rain = -1
	},
	["AZ BULUTLU"] = {
		type = "CLOUDS",
		rain = -1
	},
	["ÇOK BULUTLU"] = {
		type = "CLOUDS",
		rain = -1
	},
	["HAFİF SAĞANAK YAĞIŞLI"] = {
		type = "RAIN",
		rain = 0.3
	},
	["PUS"] = {
		type = "FOGGY",
		rain = -1
	}
}

local curWeather = weathers["AÇIK"].type
local state
local ws
local wd
local rain

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	while true do
		if curWeather ~= state then
			curWeather = state
			SetWeatherTypeOverTime(curWeather, 15.0)
			SetRainLevel(rain)
			Citizen.Wait(5000)
		end
		Citizen.Wait(10)
		ClearOverrideWeather()
        ClearWeatherTypePersist()
		SetWeatherTypePersist(curWeather)
        SetWeatherTypeNow(curWeather)
        SetWeatherTypeNowPersist(curWeather)
		SetRainLevel(rain)
		if ws and state ~= nil then
			if ws > 0.0 then
				SetWindSpeed(ws)
				SetWindDirection(wd)
			else
				SetWindSpeed(0.0)
				SetWindDirection(0.0)
			end
		end
		if curWeather == 'XMAS' then
			SetForceVehicleTrails(true)
			SetForcePedFootstepsTracks(true)
		else
			SetForceVehicleTrails(false)
			SetForcePedFootstepsTracks(false)
		end
		Citizen.Wait(1000)
	end
end)

RegisterNetEvent("real_weather:setWeather")
AddEventHandler("real_weather:setWeather", function(st, wS, wD)
ws = wS
wd = wD
state = weathers[st].type
rain = weathers[st].rain
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("real_weather:syncWeatherOnSpawn")
end)