local ESX = exports['es_extended']:getSharedObject()
local PlayerData = {}
local trackers = {}

-- Load GPS Tracker NUI
Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
    end
    
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    
    ESX.PlayerData = ESX.GetPlayerData()
    
    SendNUIMessage({
        action = 'load',
        trackers = trackers
    })
end)

-- Register NUI Callback
RegisterNUICallback('createTracker', function(data, cb)
    TriggerServerEvent('gps_tracker:createTracker', data.trackerName, data.frequency)
    cb('ok')
end)

-- Register NUI Callback
RegisterNUICallback('joinTracker', function(data, cb)
    TriggerServerEvent('gps_tracker:joinTracker', data.frequency)
    cb('ok')
end)

-- Register NUI Callback
RegisterNUICallback('pingTracker', function(data, cb)
    TriggerServerEvent('gps_tracker:pingTracker', data.frequency)
    cb('ok')
end)

-- Update Tracker Positions
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.GPSTracker.UpdateInterval)
        
        for frequency, tracker in pairs(trackers) do
            if tracker.active then
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
                
                TriggerServerEvent('gps_tracker:updatePosition', frequency, coords.x, coords.y, coords.z)
            end
        end
    end
end)

-- Handle Tracker Updates
RegisterNetEvent('gps_tracker:updateTrackers')
AddEventHandler('gps_tracker:updateTrackers', function(newTrackers)
    trackers = newTrackers
    
    SendNUIMessage({
        action = 'update',
        trackers = trackers
    })
end)

-- Handle Tracker Ping
RegisterNetEvent('gps_tracker:ping')
AddEventHandler('gps_tracker:ping', function(frequency)
    if trackers[frequency] and trackers[frequency].active then
        PlaySoundFrontend(-1, Config.GPSTracker.NotificationSound, 'HUD_MINI_GAME_SOUNDSET', true)
    end
end)