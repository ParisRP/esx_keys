ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Function to use a vehicle key
RegisterNetEvent('esx_keys:useVehicleKey')
AddEventHandler('esx_keys:useVehicleKey', function(vehiclePlate)
    local playerPed = PlayerPedId()
    local vehicleEntity = GetClosestVehicle(GetEntityCoords(playerPed), 10.0, 0, 70)

    if DoesEntityExist(vehicleEntity) then
        local plate = GetVehicleNumberPlateText(vehicleEntity)

        -- Check if the vehicle belongs to the player
        if plate == vehiclePlate then
            TaskWarpPedIntoVehicle(playerPed, vehicleEntity, -1)
            ESX.ShowNotification('You have used your vehicle key.')
        else
            ESX.ShowNotification('This is not your vehicle.')
        end
    end
end)

-- Function to use a property key
RegisterNetEvent('esx_keys:usePropertyKey')
AddEventHandler('esx_keys:usePropertyKey', function(propertyId)
    -- Here you can add specific actions for properties
    ESX.ShowNotification('You have used your property key.')
end)
