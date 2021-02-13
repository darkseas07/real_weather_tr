local api = "localhost/api/getWeather.php"
local data
local ws
local wd
local state

Citizen.CreateThread(function()
    while true do
    syncWeather()
    Citizen.Wait(60000)
    end
end)

function syncWeather()
    PerformHttpRequest(api, function (errorCode, resultData, resultHeaders)
        if errorCode == 200 then
            data = json.decode(resultData)
            ws = data.ws
            wd = data.wd
            state = data.state
            TriggerClientEvent("real_weather:setWeather", -1, state, ws, wd)
        else return nil
        end
    end)
end

RegisterServerEvent("real_weather:syncWeatherOnSpawn")
AddEventHandler("real_weather:syncWeatherOnSpawn", function()
    TriggerClientEvent("real_weather:setWeather", source, state, ws, wd)
end)