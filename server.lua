ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Commande pour verrouiller un véhicule
RegisterNetEvent('esx_keys:lockVehicle')
AddEventHandler('esx_keys:lockVehicle', async function(vehiclePlate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifier si le joueur a une clé pour ce véhicule
    local count = await MySQL.scalar('SELECT count(*) FROM keys_inventory_items WHERE owner = ? AND name = ?', {xPlayer.identifier, 'vehicle_key_' .. vehiclePlate})

    if count > 0 then
        -- Logique de verrouillage/déverrouillage ici
        TriggerClientEvent('esx:showNotification', _source, 'You locked/unlocked the vehicle with plate ' .. vehiclePlate)
    else
        TriggerClientEvent('esx:showNotification', _source, 'You don\'t have the key for this vehicle.')
    end
end)

-- Commande pour partager une clé de véhicule avec un autre joueur
RegisterNetEvent('esx_keys:shareVehicleKey')
AddEventHandler('esx_keys:shareVehicleKey', async function(targetPlayer, vehiclePlate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifier si le joueur possède la clé
    local count = await MySQL.scalar('SELECT count(*) FROM keys_inventory_items WHERE owner = ? AND name = ?', {xPlayer.identifier, 'vehicle_key_' .. vehiclePlate})

    if count > 0 then
        local target = ESX.GetPlayerFromId(targetPlayer)
        if target then
            -- Partager la clé avec le joueur cible
            await MySQL.query('INSERT INTO keys_inventory_items (inventory_name, name, count, owner) VALUES (?, ?, ?, ?)', 
                {'vehicle_keys', 'vehicle_key_' .. vehiclePlate, 1, target.identifier})

            TriggerClientEvent('esx:showNotification', _source, 'You have shared your key with player ' .. target.name)
            TriggerClientEvent('esx:showNotification', targetPlayer, 'You have received a shared key for the vehicle with plate ' .. vehiclePlate)
        else
            TriggerClientEvent('esx:showNotification', _source, 'Target player not found.')
        end
    else
        TriggerClientEvent('esx:showNotification', _source, 'You don\'t have the key for this vehicle.')
    end
end)

-- Commande pour verrouiller ou déverrouiller une propriété
RegisterNetEvent('esx_keys:lockProperty')
AddEventHandler('esx_keys:lockProperty', async function(propertyId)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifier si le joueur possède la clé pour cette propriété
    local count = await MySQL.scalar('SELECT count(*) FROM keys_inventory_items WHERE owner = ? AND name = ?', {xPlayer.identifier, 'property_key_' .. propertyId})

    if count > 0 then
        -- Logique de verrouillage/déverrouillage de la propriété ici
        TriggerClientEvent('esx:showNotification', _source, 'You locked/unlocked the property with ID ' .. propertyId)
    else
        TriggerClientEvent('esx:showNotification', _source, 'You don\'t have the key for this property.')
    end
end)

-- Commande pour obtenir les clés d'un joueur
RegisterNetEvent('esx_keys:getKeys')
AddEventHandler('esx_keys:getKeys', async function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Récupérer les clés du joueur
    local keys = await MySQL.query('SELECT name FROM keys_inventory_items WHERE owner = ?', {xPlayer.identifier})

    if keys and #keys > 0 then
        local keysList = ""
        for _, key in ipairs(keys) do
            keysList = keysList .. key.name .. "\n"
        end
        TriggerClientEvent('esx:showNotification', _source, 'Your keys:\n' .. keysList)
    else
        TriggerClientEvent('esx:showNotification', _source, 'You don\'t have any keys.')
    end
end)

-- Commande pour supprimer une clé
RegisterNetEvent('esx_keys:removeKey')
AddEventHandler('esx_keys:removeKey', async function(vehiclePlate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifier si le joueur possède la clé pour ce véhicule
    local count = await MySQL.scalar('SELECT count(*) FROM keys_inventory_items WHERE owner = ? AND name = ?', {xPlayer.identifier, 'vehicle_key_' .. vehiclePlate})

    if count > 0 then
        -- Supprimer la clé de la base de données
        await MySQL.query('DELETE FROM keys_inventory_items WHERE owner = ? AND name = ?', {xPlayer.identifier, 'vehicle_key_' .. vehiclePlate})
        TriggerClientEvent('esx:showNotification', _source, 'You have removed the key for vehicle ' .. vehiclePlate)
    else
        TriggerClientEvent('esx:showNotification', _source, 'You don\'t have the key for this vehicle.')
    end
end)
