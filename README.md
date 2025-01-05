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


__________________________________________________________________

Dependencies Make sure the following resources are installed and configured: 

• es_extended 
• esx_vehicleshop 
• esx_property 
• esx_addoninventory

How to use the script 1. Install the script: Download the files and place them in a folder named esx_keys. Add the script name in your server.cfg file to start the script:

start esx_keys

Using Keys: When a player purchases a vehicle through esx_vehicleshop, a vehicle key is automatically added to their inventory. When a player purchases a property through esx_property, a property key is added to their inventory. Players can use keys by selecting them in their inventory.



