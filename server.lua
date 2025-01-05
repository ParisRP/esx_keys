ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Ajouter une clé de véhicule à l'inventaire d'un joueur
RegisterNetEvent('esx_keys:addVehicleKey')
AddEventHandler('esx_keys:addVehicleKey', function(vehiclePlate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifie si le joueur a déjà cette clé
    MySQL.Async.fetchScalar('SELECT count(*) FROM keys_inventory_items WHERE owner = @owner AND plate = @plate AND inventory_name = @inventory_name',
        {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = vehiclePlate,
            ['@inventory_name'] = 'vehicle_keys'
        }, function(count)
            if count == 0 then
                -- Ajoute la clé
                MySQL.Async.execute('INSERT INTO keys_inventory_items (inventory_name, name, plate, count, owner) VALUES (@inventory_name, @name, @plate, @count, @owner)',
                {
                    ['@inventory_name'] = 'vehicle_keys',
                    ['@name'] = 'car_key_' .. vehiclePlate,
                    ['@plate'] = vehiclePlate,
                    ['@count'] = 1,
                    ['@owner'] = xPlayer.identifier
                }, function(rowsChanged)
                    TriggerClientEvent('esx:showNotification', _source, "You received a key for vehicle with plate " .. vehiclePlate)
                end)
            else
                TriggerClientEvent('esx:showNotification', _source, "You already have a key for this vehicle.")
            end
        end)
end)

-- Ajouter un joueur à la liste de partage de clé
RegisterNetEvent('esx_keys:shareVehicleKey')
AddEventHandler('esx_keys:shareVehicleKey', function(vehiclePlate, targetPlayer)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchScalar('SELECT shared_with FROM keys_inventory_items WHERE owner = @owner AND plate = @plate AND inventory_name = @inventory_name',
        {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = vehiclePlate,
            ['@inventory_name'] = 'vehicle_keys'
        }, function(sharedWith)
            if sharedWith then
                local sharedList = sharedWith ~= '' and sharedWith or ''
                if not string.find(sharedList, targetPlayer) then
                    sharedList = sharedList .. ',' .. targetPlayer

                    MySQL.Async.execute('UPDATE keys_inventory_items SET shared_with = @shared_with WHERE owner = @owner AND plate = @plate AND inventory_name = @inventory_name',
                    {
                        ['@shared_with'] = sharedList,
                        ['@owner'] = xPlayer.identifier,
                        ['@plate'] = vehiclePlate,
                        ['@inventory_name'] = 'vehicle_keys'
                    }, function(rowsChanged)
                        TriggerClientEvent('esx:showNotification', _source, "You have shared your key for the vehicle with plate " .. vehiclePlate .. " with player " .. targetPlayer)
                        -- Optionnel : notifiez le joueur cible
                        TriggerClientEvent('esx:showNotification', targetPlayer, "You have received a shared key for the vehicle with plate " .. vehiclePlate)
                    end)
                else
                    TriggerClientEvent('esx:showNotification', _source, "You have already shared this key with this player.")
                end
            else
                TriggerClientEvent('esx:showNotification', _source, "You do not have a key for this vehicle.")
            end
        end)
end)

-- Retirer un joueur de la liste de partage de clé
RegisterNetEvent('esx_keys:removeSharedKey')
AddEventHandler('esx_keys:removeSharedKey', function(vehiclePlate, targetPlayer)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchScalar('SELECT shared_with FROM keys_inventory_items WHERE owner = @owner AND plate = @plate AND inventory_name = @inventory_name',
        {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = vehiclePlate,
            ['@inventory_name'] = 'vehicle_keys'
        }, function(sharedWith)
            if sharedWith then
                local sharedList = sharedWith
                sharedList = string.gsub(sharedList, targetPlayer, "")  -- Retirer le joueur du partage

                MySQL.Async.execute('UPDATE keys_inventory_items SET shared_with = @shared_with WHERE owner = @owner AND plate = @plate AND inventory_name = @inventory_name',
                {
                    ['@shared_with'] = sharedList,
                    ['@owner'] = xPlayer.identifier,
                    ['@plate'] = vehiclePlate,
                    ['@inventory_name'] = 'vehicle_keys'
                }, function(rowsChanged)
                    TriggerClientEvent('esx:showNotification', _source, "You have removed the shared key for the vehicle with plate " .. vehiclePlate .. " from player " .. targetPlayer)
                    -- Optionnel : notifiez le joueur cible
                    TriggerClientEvent('esx:showNotification', targetPlayer, "Your access to the key for vehicle with plate " .. vehiclePlate .. " has been revoked.")
                end)
            else
                TriggerClientEvent('esx:showNotification', _source, "You do not have a shared key for this vehicle.")
            end
        end)
end)
