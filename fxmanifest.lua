fx_version 'cerulean'
game 'gta5'

author 'Gemini'
description 'Advanced Multi-Job & Career Management System'
version '1.1.0'

-- Using ox_lib for optimized callbacks
dependency 'ox_lib'

ui_page 'html/index.html'

files {
    'html/index.html'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
    '@oxmysql/lib/utils.lua', -- This helps initialize the MySQL global
}

lua54 'yes'