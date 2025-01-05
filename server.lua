ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Give a vehicle key item
RegisterNetEvent('esx_keys:giveVehicleKey')
AddEventHandler('esx_keys:giveVehicleKey', function(vehiclePlate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemName = 'car_key'  -- Vehicle key item name
    local count = 1

    -- Check if the player has the item
    if xPlayer.getInventoryItem(itemName).count < count then
        xPlayer.addInventoryItem(itemName, count)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "You have received a vehicle key.")
    else
        TriggerClientEvent('esx:showNotification', xPlayer.source, "You already have a key.")
    end
end)

-- Give a property key item
RegisterNetEvent('esx_keys:givePropertyKey')
AddEventHandler('esx_keys:givePropertyKey', function(propertyId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemName = 'property_key'  -- Property key item name
    local count = 1

    -- Check if the player has the item
    if xPlayer.getInventoryItem(itemName).count < count then
        xPlayer.addInventoryItem(itemName, count)
        TriggerClientEvent('esx:showNotification', xPlayer.source, "You have received a property key.")
    else
        TriggerClientEvent('esx:showNotification', xPlayer.source, "You already have a key.")
    end
end)

-- When a vehicle is purchased, give a key to the player
AddEventHandler('esx_vehicleshop:vehicleBought', function(vehicle, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehiclePlate = GetVehicleNumberPlateText(vehicle)

    -- Give the vehicle key
    TriggerEvent('esx_keys:giveVehicleKey', vehiclePlate)
end)

-- When a property is purchased, give a key to the player
AddEventHandler('esx_property:propertyPurchased', function(propertyId)
    local xPlayer = ESX.GetPlayerFromId(source)

    -- Give the property key
    TriggerEvent('esx_keys:givePropertyKey', propertyId)
end)
