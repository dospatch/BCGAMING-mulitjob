fx_version 'cerulean'
game 'gta5'

author 'BCGAMING'
description 'Advanced Career Center & Multi-Job System'
version '1.1.0'

-- Dependencies
dependency 'ox_lib'
dependency 'oxmysql'

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
    '@oxmysql/lib/utils.lua',
    'server.lua'
}

lua54 'yes'