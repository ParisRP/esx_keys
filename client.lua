ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Commande pour verrouiller et déverrouiller les véhicules
RegisterCommand('lockvehicle', function(source, args, rawCommand)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle and vehicle ~= 0 then
        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerServerEvent('esx_keys:lockVehicle', plate)
    else
        TriggerEvent('esx:showNotification', 'You are not in a vehicle.')
    end
end, false)

-- Commande pour partager une clé de véhicule
RegisterCommand('sharevehiclekey', function(source, args, rawCommand)
    local targetPlayer = tonumber(args[1]) -- ID du joueur à qui partager la clé
    local vehiclePlate = args[2] -- Plaque du véhicule
    TriggerServerEvent('esx_keys:shareVehicleKey', targetPlayer, vehiclePlate)
end, false)

-- Commande pour verrouiller ou déverrouiller une propriété
RegisterCommand('lockproperty', function(source, args, rawCommand)
    local propertyId = args[1] -- ID de la propriété
    TriggerServerEvent('esx_keys:lockProperty', propertyId)
end, false)
