RegisterCommand('sharevehiclekey', function(source, args, rawCommand)
    local plate = args[1]
    local targetPlayer = args[2]
    if plate and targetPlayer then
        TriggerServerEvent('esx_keys:shareVehicleKey', plate, targetPlayer)
    else
        print("Please provide the vehicle plate and the target player's ID.")
    end
end, false)

RegisterCommand('removevehiclekey', function(source, args, rawCommand)
    local plate = args[1]
    local targetPlayer = args[2]
    if plate and targetPlayer then
        TriggerServerEvent('esx_keys:removeSharedKey', plate, targetPlayer)
    else
        print("Please provide the vehicle plate and the target player's ID.")
    end
end, false)
