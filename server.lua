ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Commande pour verrouiller un véhicule
RegisterNetEvent('esx_keys:lockVehicle')
AddEventHandler('esx_keys:lockVehicle', function(vehiclePlate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifier si le joueur a une clé pour ce véhicule
    MySQL.Async.fetchScalar('SELECT count(*) FROM keys_inventory_items WHERE owner = @owner AND name = @name',
    {
        ['@owner'] = xPlayer.identifier,
        ['@name'] = 'vehicle_key_' .. vehiclePlate
    }, function(count)
        if count > 0 then
            -- Logique de verrouillage/déverrouillage ici
            TriggerClientEvent('esx:showNotification', _source, 'You locked/unlocked the vehicle with plate ' .. vehiclePlate)
        else
            TriggerClientEvent('esx:showNotification', _source, 'You don\'t have the key for this vehicle.')
        end
    end)
end)

-- Commande pour partager une clé avec un autre joueur
RegisterNetEvent('esx_keys:shareVehicleKey')
AddEventHandler('esx_keys:shareVehicleKey', function(targetPlayer, vehiclePlate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifier que le joueur possède la clé
    MySQL.Async.fetchScalar('SELECT count(*) FROM keys_inventory_items WHERE owner = @owner AND name = @name',
    {
        ['@owner'] = xPlayer.identifier,
        ['@name'] = 'vehicle_key_' .. vehiclePlate
    }, function(count)
        if count > 0 then
            local target = ESX.GetPlayerFromId(targetPlayer)
            if target then
                -- Partager la clé
                MySQL.Async.execute('INSERT INTO keys_inventory_items (inventory_name, name, count, owner) VALUES (@inventory_name, @name, @count, @owner)',
                {
                    ['@inventory_name'] = 'vehicle_keys',
                    ['@name'] = 'vehicle_key_' .. vehiclePlate,
                    ['@count'] = 1,
                    ['@owner'] = target.identifier
                })
                TriggerClientEvent('esx:showNotification', _source, 'You have shared your key with player ' .. target.name)
                TriggerClientEvent('esx:showNotification', targetPlayer, 'You have received a shared key for the vehicle with plate ' .. vehiclePlate)
            else
                TriggerClientEvent('esx:showNotification', _source, 'Target player not found.')
            end
        else
            TriggerClientEvent('esx:showNotification', _source, 'You don\'t have the key for this vehicle.')
        end
    end)
end)

-- Commande pour verrouiller ou déverrouiller une propriété
RegisterNetEvent('esx_keys:lockProperty')
AddEventHandler('esx_keys:lockProperty', function(propertyId)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifier si le joueur possède la clé pour cette propriété
    MySQL.Async.fetchScalar('SELECT count(*) FROM keys_inventory_items WHERE owner = @owner AND name = @name',
    {
        ['@owner'] = xPlayer.identifier,
        ['@name'] = 'property_key_' .. propertyId
    }, function(count)
        if count > 0 then
            -- Logique de verrouillage/déverrouillage de la propriété
            TriggerClientEvent('esx:showNotification', _source, 'You locked/unlocked the property with ID ' .. propertyId)
        else
            TriggerClientEvent('esx:showNotification', _source, 'You don\'t have the key for this property.')
        end
    end)
end)
