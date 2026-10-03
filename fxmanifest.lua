fx_version 'cerulean'
game 'gta5'

author 'GpsTrackerSystem'
description 'FiveM ESX resource named gps_tracker using ox_lib, ox_inventory and oxmysql. Concept: phone-style GP'
version '1.0.0'

dependencies {
    'es_extended'
}

client_scripts {
    'client.lua',
    'client/*.lua'
}

server_scripts {
    'server.lua',
    'server/*.lua'
}

shared_scripts {
    'config.lua',
    'shared.lua'
}

ui_page 'html/index.html'

files {
    'html/*.html',
    'html/*.css',
    'html/*.js'
}
