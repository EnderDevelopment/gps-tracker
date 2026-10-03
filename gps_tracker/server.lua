local ESX = exports['es_extended']:getSharedObject()
local trackers = {}

-- Load Trackers from Database
MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM gps_trackers', {}, function(result)
        for _, row in ipairs(result) do
            trackers[row.frequency] = {
                ownerId = row.owner_id,
                trackerName = row.tracker_name,
                frequency = row.frequency,
                members = {},
                active = false
            }
        end
    end)
end)

-- Create Tracker
RegisterServerEvent('gps_tracker:createTracker')
AddEventHandler('gps_tracker:createTracker', function(trackerName, frequency)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        if not trackers[frequency] then
            trackers[frequency] = {
                ownerId = xPlayer.identifier,
                trackerName = trackerName,
                frequency = frequency,
                members = {},
                active = false
            }
            
            MySQL.Async.execute('INSERT INTO gps_trackers (owner_id, tracker_name, frequency) VALUES (@owner_id, @tracker_name, @frequency)', {
                ['@owner_id'] = xPlayer.identifier,
                ['@tracker_name'] = trackerName,
                ['@frequency'] = frequency
            }, function(rowsChanged)
                if rowsChanged > 0 then
                    TriggerClientEvent('gps_tracker:updateTrackers', -1, trackers)
                end
            end)
        else
            TriggerClientEvent('esx:showNotification', source, _U('frequency_exists'))
        end
    end
end)

-- Join Tracker
RegisterServerEvent('gps_tracker:joinTracker')
AddEventHandler('gps_tracker:joinTracker', function(frequency)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer and trackers[frequency] then
        if not trackers[frequency].members[xPlayer.identifier] then
            trackers[frequency].members[xPlayer.identifier] = true
            trackers[frequency].active = true
            
            TriggerClientEvent('gps_tracker:updateTrackers', -1, trackers)
        else
            TriggerClientEvent('esx:showNotification', source, _U('already_joined'))
        end
    end
end)

-- Update Position
RegisterServerEvent('gps_tracker:updatePosition')
AddEventHandler('gps_tracker:updatePosition', function(frequency, x, y, z)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer and trackers[frequency] and trackers[frequency].members[xPlayer.identifier] then
        trackers[frequency].position = {x = x, y = y, z = z}
        
        TriggerClientEvent('gps_tracker:updateTrackers', -1, trackers)
    end
end)

-- Ping Tracker
RegisterServerEvent('gps_tracker:pingTracker')
AddEventHandler('gps_tracker:pingTracker', function(frequency)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer and trackers[frequency] then
        for identifier, _ in pairs(trackers[frequency].members) do
            if identifier ~= xPlayer.identifier then
                TriggerClientEvent('gps_tracker:ping', identifier, frequency)
            end
        end
    end
end)