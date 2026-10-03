fx_version 'cerulean'
game 'gta5'

description 'GPS Tracker System'
version '1.0.0'

author 'EnderDevelopment'

dependencies {
    'es_extended',
    'ox_lib',
    'ox_inventory',
    'oxmysql'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

shared_scripts {
    'config.lua',
    'locales.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css'
}