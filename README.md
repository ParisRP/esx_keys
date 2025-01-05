Manage keys in inventory via esx_addoninventory In server.lua you can manage keys as items in players inventory.

add on esx_addoninventory/server.lua
________________________________________________________________

ESX.RegisterUsableItem('car_key', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehiclePlate = 'CAR_PLATE_NUMBER'  -- Replace with the player's vehicle plate
    TriggerClientEvent('esx_keys:useVehicleKey', source, vehiclePlate)
end)

ESX.RegisterUsableItem('property_key', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local propertyId = 'PROPERTY_ID'  -- Replace with the player's property ID
    TriggerClientEvent('esx_keys:usePropertyKey', source, propertyId)
end)
