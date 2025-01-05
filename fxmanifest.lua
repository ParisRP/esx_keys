fx_version 'cerulean'
game 'gta5'

author 'Paris RP'
description 'Vehicle and Property Keys with ESX Legacy'
version '1.0.0'

dependencies {
    'es_extended',
    'esx_vehicleshop',
    'esx_property',
    'esx_addoninventory'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua',
    '@es_extended/locale.lua',
    'locales/en.lua'  -- If you have a language file
}
